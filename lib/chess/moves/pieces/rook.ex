defmodule Chess.Moves.Pieces.Rook do
  @moduledoc false

  alias Chess.Moves.Generator

  def moves(board, {file, rank}) do
    Generator.moves(board, {file, rank}, {0, 1}) ++
      Generator.moves(board, {file, rank}, {0, -1}) ++
      Generator.moves(board, {file, rank}, {-1, 0}) ++
      Generator.moves(board, {file, rank}, {1, 0})
  end
end
