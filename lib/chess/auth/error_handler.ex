defmodule Chess.Auth.ErrorHandler do
  @moduledoc false

  use ChessWeb, :controller

  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:info, "You must be logged in")
    |> redirect(to: "/")
    |> halt()
  end
end
