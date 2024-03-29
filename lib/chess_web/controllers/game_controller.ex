defmodule ChessWeb.GameController do
  use ChessWeb, :controller

  alias Chess.Emails
  alias Chess.Mailer
  alias Chess.Store.Game
  alias Chess.Store.User

  import Chess.Auth, only: [current_user: 1]

  def index(conn, _params) do
    changeset = Game.changeset(%Game{})

    games =
      conn
      |> current_user()
      |> Game.for_user()
      |> Game.ordered()
      |> preload([:user, :opponent])
      |> Repo.all()

    conn
    |> render("index.html", games: games, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Game.changeset(%Game{})

    conn
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"game" => game}) do
    %Game{user_id: current_user(conn).id}
    |> Game.changeset(game)
    |> Repo.insert()
    |> case do
      {:ok, game} ->
        conn
        |> Emails.new_game_email(
          game
          |> Repo.preload(:user)
          |> Repo.preload(:opponent)
        )
        |> Mailer.deliver_later()

        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :show, game))

      {:error, changeset} ->
        opponents =
          conn
          |> current_user()
          |> User.opponents()
          |> Repo.all()

        conn
        |> render("new.html", changeset: changeset, opponents: opponents)
    end
  end

  def show(conn, %{"id" => id}) do
    query =
      conn
      |> current_user()
      |> Game.for_user()
      |> preload([:user, :opponent])

    game =
      query
      |> Repo.get!(id)

    conn
    |> render("show.html", game: game)
  end

  def delete(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: game_path(conn, :index))
  end
end
