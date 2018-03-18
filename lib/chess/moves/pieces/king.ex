defmodule Chess.Moves.Pieces.King do
  @moduledoc false

  alias Chess.Moves.Generator

  def moves(board, {file, rank}) do
    Generator.moves(board, {file, rank}, patterns())
  end

  defp patterns do
    [{1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}, {-1, 0}, {-1, 1}, {0, 1}]
  end
end
