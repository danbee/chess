defmodule Chess.Moves do
  @moduledoc false

  alias Chess.Moves.Pawn
  alias Chess.Moves.Rook

  def available(board, {file, rank}) do
    piece = board["#{file},#{rank}"]

    case piece do
      %{"type" => "pawn"} ->
        Pawn.moves(board, {file, rank})
      %{"type" => "rook"} ->
        Rook.moves(board, {file, rank})
      %{"type" => "bishop"} ->
        []
      %{"type" => "knight"} ->
        []
      %{"type" => "king"} ->
        []
      %{"type" => "queen"} ->
        []
    end
  end
end
