defmodule Chess.PageController do
  use Chess.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
