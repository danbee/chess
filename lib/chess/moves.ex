defmodule Chess.Moves do
  @moduledoc false

  alias Chess.Moves.Pawn
  alias Chess.Moves.Bishop
  alias Chess.Moves.Knight
  alias Chess.Moves.Rook
  alias Chess.Moves.Queen
  alias Chess.Moves.King

  def available(board, {file, rank}) do
    piece = board["#{file},#{rank}"]

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
