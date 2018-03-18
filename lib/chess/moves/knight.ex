defmodule Chess.Moves.Knight do
  @moduledoc false

  alias Chess.Moves.Generator

  def moves(board, {file, rank}) do
    Generator.moves(board, {file, rank}, pattern())
  end

  def pattern do
    [{1, 2}, {2, 1}, {-1, 2}, {-2, 1}, {1, -2}, {2, -1}, {-1, -2}, {-2, -1}]
  end
end
