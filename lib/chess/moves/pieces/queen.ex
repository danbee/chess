defmodule Chess.Moves.Pieces.Queen do
  @moduledoc false

  alias Chess.Moves.Pieces.Rook
  alias Chess.Moves.Pieces.Bishop

  def moves(board, {file, rank}) do
    Rook.moves(board, {file, rank}) ++
      Bishop.moves(board, {file, rank})
  end
end
