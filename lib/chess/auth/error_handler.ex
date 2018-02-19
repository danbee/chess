defmodule Chess.Auth.ErrorHandler do
  @moduledoc false

  use ChessWeb, :controller

  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    case get_format(conn) do
      "html" ->
        conn
        |> put_flash(:info, "You must be logged in")
        |> redirect(to: "/")
        |> halt()
      "json" ->
        conn
        |> put_status(403)
        |> json(%{status: 403, message: "Not authorized"})
    end
  end
end
