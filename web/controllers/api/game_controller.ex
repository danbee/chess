defmodule Chess.Api.GameController do
  use Chess.Web, :controller

  alias Chess.Game

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)
    render conn, "show.json", game: game
  end
end
