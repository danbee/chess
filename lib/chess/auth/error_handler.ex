defmodule Chess.Auth.ErrorHandler do
  @moduledoc false

  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> Phoenix.Controller.put_flash(:info, "You must be logged in")
    |> Phoenix.Controller.redirect(to: "/")
    |> halt()
  end
end
