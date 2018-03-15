defmodule Chess.Moves.Knight do
  @moduledoc false

  alias Chess.Moves.Generator

  def moves(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, patterns())
  end

  defp patterns do
    [{1, 2}, {2, 1}, {-1, 2}, {-2, 1}, {1, -2}, {2, -1}, {-1, -2}, {-2, -1}]
  end
end
