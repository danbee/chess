defmodule Chess.Moves.Pieces.Bishop do
  @moduledoc false

  alias Chess.Moves.Generator

  def moves(board, {file, rank}) do
    Generator.moves(board, {file, rank}, {1, 1}) ++
      Generator.moves(board, {file, rank}, {1, -1}) ++
      Generator.moves(board, {file, rank}, {-1, 1}) ++
      Generator.moves(board, {file, rank}, {-1, -1})
  end
end
