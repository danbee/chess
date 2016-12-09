defmodule Chess.Api.GameController do
  use Chess.Web, :controller

  alias Chess.Game

  def show(conn, _params) do
    render conn, "show.json", id: 1
  end
end
