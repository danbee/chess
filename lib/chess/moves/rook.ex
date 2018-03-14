defmodule Chess.Moves.Rook do
  @moduledoc false

  alias Chess.Moves.Generator

  def moves(board, {file, rank}) do
    moves_north(board, {file, rank}) ++
      moves_south(board, {file, rank}) ++
      moves_east(board, {file, rank}) ++
      moves_west(board, {file, rank})
  end

  defp moves_north(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {0, +1})
  end

  defp moves_south(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {0, -1})
  end

  defp moves_east(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {+1, 0})
  end

  defp moves_west(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> Generator.moves(board, {file, rank}, {-1, 0})
  end
end
