defmodule Chess.Moves.Queen do
  @moduledoc false

  alias Chess.Moves.Rook
  alias Chess.Moves.Bishop

  def moves(board, {file, rank}) do
    Rook.moves(board, {file, rank}) ++
      Bishop.moves(board, {file, rank})
  end
end
