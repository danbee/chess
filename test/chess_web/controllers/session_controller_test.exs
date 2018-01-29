defmodule Chess.SessionControllerTest do
  use ChessWeb.ConnCase

  test "shows log in form", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Log in"
  end
end
