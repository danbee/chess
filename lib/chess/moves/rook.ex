defmodule Chess.Moves.Rook do
  @moduledoc false

  def moves(board, {file, rank}) do
    moves_north(board, {file, rank}) ++
      moves_south(board, {file, rank}) ++
      moves_east(board, {file, rank}) ++
      moves_west(board, {file, rank})
  end

  defp moves_north(_board, {_file, 7}), do: []
  defp moves_north(board, {file, rank}) do
    [{file, rank + 1} | moves_north(board, {file, rank + 1})]
  end

  defp moves_south(_board, {_file, 0}), do: []
  defp moves_south(board, {file, rank}) do
    [{file, rank - 1} | moves_south(board, {file, rank - 1})]
  end

  defp moves_east(_board, {7, _rank}), do: []
  defp moves_east(board, {file, rank}) do
    [{file + 1, rank} | moves_east(board, {file + 1, rank})]
  end

  defp moves_west(_board, {0, _rank}), do: []
  defp moves_west(board, {file, rank}) do
    [{file - 1, rank} | moves_west(board, {file - 1, rank})]
  end
end
