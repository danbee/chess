defmodule Chess.Moves do
  @moduledoc false

  alias Chess.Board

  alias Chess.Moves.Pieces.Pawn
  alias Chess.Moves.Pieces.Bishop
  alias Chess.Moves.Pieces.Knight
  alias Chess.Moves.Pieces.Rook
  alias Chess.Moves.Pieces.Queen
  alias Chess.Moves.Pieces.King

  def available(board, {file, rank}) do
    piece =
      board
      |> Board.piece({file, rank})

    case piece do
      %{"type" => "pawn"} ->
        Pawn.moves(board, {file, rank})
      %{"type" => "rook"} ->
        Rook.moves(board, {file, rank})
      %{"type" => "bishop"} ->
        Bishop.moves(board, {file, rank})
      %{"type" => "knight"} ->
        Knight.moves(board, {file, rank})
      %{"type" => "king"} ->
        King.moves(board, {file, rank})
      %{"type" => "queen"} ->
        Queen.moves(board, {file, rank})
    end
  end
end
