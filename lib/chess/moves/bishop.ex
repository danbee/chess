defmodule Chess.Moves.Bishop do
  @moduledoc false

  alias Chess.Moves.Generator

  def moves(board, {file, rank}) do
    moves_northeast(board, {file, rank}) ++
      moves_southeast(board, {file, rank}) ++
      moves_northwest(board, {file, rank}) ++
      moves_southwest(board, {file, rank})
  end

  defp moves_northeast(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {1, 1})
  end

  defp moves_southeast(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {1, -1})
  end

  defp moves_northwest(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {-1, 1})
  end

  defp moves_southwest(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {-1, -1})
  end
end
