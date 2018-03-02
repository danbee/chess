defmodule Chess.ApiGameControllerTest do
  use ChessWeb.ConnCase

  alias Chess.Auth.Guardian

  import Chess.Factory

  test "shows chosen game", %{conn: conn} do
    user = insert(:user)
    opponent = insert(:user, %{username: "revali"})
    game = insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    conn =
      conn
      |> login(user)
      |> get(api_game_path(conn, :show, game))

    assert json_response(conn, 200)
  end

  test "does not show a game if the user is not a player", %{conn: conn} do
    user = insert(:user)
    opponent = insert(:user, %{username: "revali"})
    game = insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    other_user = insert(:user, %{username: "mipha"})

    conn =
      conn
      |> login(other_user)

    assert_error_sent 404, fn ->
      get(conn, api_game_path(conn, :show, game.id))
    end
  end

  test "responds with 403 if user is not logged in", %{conn: conn} do
    user = insert(:user)
    opponent = insert(:user, %{username: "revali"})
    game = insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    conn =
      conn
      |> get(api_game_path(conn, :show, game.id))

    assert json_response(conn, 403)
  end

  test "does not update a game if the user is not a player", %{conn: conn} do
    user = insert(:user)
    opponent = insert(:user, %{username: "revali"})
    game = insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    other_user = insert(:user, %{username: "mipha"})

    conn =
      conn
      |> login(other_user)

    assert_error_sent 404, fn ->
      patch(
        conn,
        api_game_path(conn, :update, game.id),
        %{move: %{from: [1, 1], to: [2, 1]}}
      )
    end
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    user = insert(:user)
    conn = login(conn, user)

    assert_error_sent 404, fn ->
      get(conn, api_game_path(conn, :show, -1))
    end
  end

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end
end

