defmodule ChessWeb.GameController do
  use ChessWeb, :controller

  alias Chess.Store.Game
  alias Chess.Auth.User

  def index(conn, _params) do
    changeset = Game.changeset(%Game{})
    games =
      Game
      |> Game.for_user(current_user(conn))
      |> Game.ordered
      |> Repo.all

    render(conn, "index.html", games: games, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Game.changeset(%Game{})

    query = from user in "users",
            where: user.id != ^current_user(conn).id,
            select: {user.username, user.id}

    opponents = query |> Repo.all

    render(conn, "new.html", changeset: changeset, opponents: opponents)
  end

  def create(conn, _params) do
    changeset = Game.create_changeset(
      %Game{},
      %{user_id: current_user(conn).id}
    )

    case Repo.insert(changeset) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: game_path(conn, :show, game))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)

    render(conn, "show.html", game: game)
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

  defp current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
