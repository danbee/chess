defmodule Chess.Moves do
  @moduledoc false

  alias Chess.Moves.Pawn
  alias Chess.Moves.Rook
  alias Chess.Moves.Bishop

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
        []
      %{"type" => "king"} ->
        []
      %{"type" => "queen"} ->
        []
    end
  end
end
