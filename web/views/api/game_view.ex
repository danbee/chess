defmodule Chess.Api.GameView do
  use Chess.Web, :view

  def render("show.json", %{game: game}) do
    game.board
  end
end
