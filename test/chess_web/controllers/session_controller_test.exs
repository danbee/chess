defmodule Chess.SessionControllerTest do
  use ChessWeb.ConnCase

  test "shows sign in form", %{conn: conn} do
    conn = get conn, session_path(conn, :new)
    assert html_response(conn, 200) =~ "Sign in"
  end
end
