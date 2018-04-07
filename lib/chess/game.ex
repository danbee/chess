defmodule Chess.Game do
  @moduledoc false

  alias Chess.Board
  alias Chess.Moves.Piece

  def player_checkmated?(board, colour) do
    board
    |> Board.search(%{"colour" => colour})
  end

  def king_in_check?(board, colour) do
    king =
      board
      |> Board.search(%{"type" => "king", "colour" => colour})
      |> List.first

    board
    |> Piece.attacked?(king)
  end
end
