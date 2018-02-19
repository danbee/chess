defmodule Chess.GameControllerTest do
  use ChessWeb.ConnCase

  alias Chess.Store.Game
  alias Chess.Auth.Guardian

  import Chess.Factory,
    only: [create_user: 0, create_user: 2, create_game_for: 2]

  test "lists all entries on index", %{conn: conn} do
    user = create_user()

    conn =
      conn
      |> login(user)
      |> get(game_path(conn, :index))

    assert html_response(conn, 200) =~ "Listing games"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    opponent = create_user("daruk", "deathmountain")
    attrs = %{"opponent_id" => opponent.id}

    user = create_user()

    conn =
      conn
      |> login(user)
      |> post(game_path(conn, :create), game: attrs)

    game = Repo.one(Game)

    assert redirected_to(conn) == game_path(conn, :show, game)
  end

  test "shows chosen resource", %{conn: conn} do
    user = create_user()
    opponent = create_user("revali", "vahmedoh")
    game = create_game_for(user, opponent)

    conn =
      conn
      |> login(user)
      |> get(game_path(conn, :show, game))

    assert html_response(conn, 200) =~ "<div id=\"app\" data-game-id=\"#{game.id}\">"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    user = create_user()
    conn = login(conn, user)

    assert_error_sent 404, fn ->
      get conn, game_path(conn, :show, -1)
    end
  end

  test "deletes chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    user = create_user()
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
