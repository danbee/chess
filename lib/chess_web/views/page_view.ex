defmodule ChessWeb.PageView do
  use ChessWeb, :view

  def login_link(conn) do
    gettext("Log in")
    |> link(to: session_path(conn, :new))
    |> safe_to_string
  end

  def register_link(conn) do
    gettext("Register")
    |> link(to: registration_path(conn, :new))
    |> safe_to_string
  end
end
