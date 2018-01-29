defmodule Chess.GameControllerTest do
  use ChessWeb.ConnCase

  alias Chess.Store.Game
  alias Chess.Auth.User
  alias Chess.Auth.Guardian
  @valid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = login(conn)
    conn = get conn, game_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing games"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = login(conn)
    conn = post conn, game_path(conn, :create), game: @valid_attrs
    game = Repo.one(Game)
    assert redirected_to(conn) == game_path(conn, :show, game)
  end

  test "shows chosen resource", %{conn: conn} do
    conn = login(conn)
    game = Repo.insert! %Game{}
    conn = get conn, game_path(conn, :show, game)
    assert html_response(conn, 200) =~ "<div id=\"app\" data-game-id=\"#{game.id}\">"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    conn = login(conn)
    assert_error_sent 404, fn ->
      get conn, game_path(conn, :show, -1)
    end
  end

  test "deletes chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = login(conn)
    conn = delete conn, game_path(conn, :delete, game)
    assert redirected_to(conn) == game_path(conn, :index)
    refute Repo.get(Game, game.id)
  end

  defp login(conn) do
    user = create_user()
    conn |> Guardian.Plug.sign_in(user)
  end

  defp create_user() do
    changeset = User.changeset(
      %User{},
      %{username: "link@hyrule.kingdom", password: "ilovezelda"}
    )
    Repo.insert!(changeset)
  end
end
