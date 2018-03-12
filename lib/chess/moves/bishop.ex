defmodule Chess.Moves.Bishop do
  @moduledoc false

  def moves(board, {file, rank}) do
    moves_northeast(board, {file, rank}) ++
      moves_southeast(board, {file, rank}) ++
      moves_northwest(board, {file, rank}) ++
      moves_southwest(board, {file, rank})
  end

  defp moves_northeast(_board, {7, _rank}), do: []
  defp moves_northeast(_board, {_file, 7}), do: []
  defp moves_northeast(board, {file, rank}) do
    [{file + 1, rank + 1} | moves_northeast(board, {file + 1, rank + 1})]
  end

  defp moves_southeast(_board, {7, _rank}), do: []
  defp moves_southeast(_board, {_file, 0}), do: []
  defp moves_southeast(board, {file, rank}) do
    [{file + 1, rank - 1} | moves_southeast(board, {file + 1, rank - 1})]
  end

  defp moves_northwest(_board, {0, _rank}), do: []
  defp moves_northwest(_board, {_file, 7}), do: []
  defp moves_northwest(board, {file, rank}) do
    [{file - 1, rank + 1} | moves_northwest(board, {file - 1, rank + 1})]
  end

  defp moves_southwest(_board, {0, _rank}), do: []
  defp moves_southwest(_board, {_file, 0}), do: []
  defp moves_southwest(board, {file, rank}) do
    [{file - 1, rank - 1} | moves_southwest(board, {file - 1, rank - 1})]
  end
end
