defmodule Chess.GameControllerTest do
  use ChessWeb.ConnCase

  alias Chess.Store.Game
  alias Chess.Auth.Guardian

  import Chess.Factory

  test "lists all entries on index", %{conn: conn} do
    user = insert(:user)

    conn =
      conn
      |> login(user)
      |> get(game_path(conn, :index))

    assert html_response(conn, 200) =~ "Listing games"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    opponent = insert(:user, %{email: "daruk@goron.city"})
    attrs = %{"opponent_id" => opponent.id}

    user = insert(:user)

    conn =
      conn
      |> login(user)
      |> post(game_path(conn, :create), game: attrs)

    game = Repo.one(Game)

    assert redirected_to(conn) == game_path(conn, :show, game)
  end

  test "shows chosen game", %{conn: conn} do
    user = insert(:user)
    opponent = insert(:user, %{email: "revali@rito.village"})
    game = insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    conn =
      conn
      |> login(user)
      |> get(game_path(conn, :show, game))

    assert html_response(conn, 200) =~ "<div id=\"app\" data-game-id=\"#{game.id}\">"
  end

  test "does not show a game if the user is not a player", %{conn: conn} do
    user = insert(:user)
    opponent = insert(:user, %{email: "revali@rito.village"})
    game = insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    other_user = insert(:user, %{email: "mipha@zora.domain"})

    conn =
      conn
      |> login(other_user)

    assert_error_sent 404, fn ->
      get conn, game_path(conn, :show, game.id)
    end
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    user = insert(:user)
    conn = login(conn, user)

    assert_error_sent 404, fn ->
      get conn, game_path(conn, :show, -1)
    end
  end

  test "deletes chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    user = insert(:user)
    conn = login(conn, user)
    conn = delete conn, game_path(conn, :delete, game)
    assert redirected_to(conn) == game_path(conn, :index)
    refute Repo.get(Game, game.id)
  end

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end
end
