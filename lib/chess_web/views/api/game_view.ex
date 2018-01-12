defmodule ChessWeb.Api.GameView do
  use Chess.Web, :view

  alias Chess.Board

  def render("show.json", %{game: game}) do
    Board.output(game.board)
  end
end
