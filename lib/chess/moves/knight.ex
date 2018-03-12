defmodule Chess.Moves.Knight do
  @moduledoc false

  def moves(_board, {file, rank}) do
    patterns
    |> Enum.map(fn ({fv, rv}) -> {file + fv, rank + rv} end)
    |> Enum.reject(fn ({file, rank}) ->
      file < 0 || rank < 0 || file > 7 || rank > 7
    end)
  end

  defp patterns do
    [{1, 2}, {2, 1}, {-1, 2}, {-2, 1}, {1, -2}, {2, -1}, {-1, -2}, {-2, -1}]
  end
end
