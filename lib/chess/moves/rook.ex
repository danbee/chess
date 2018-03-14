defmodule Chess.Moves.Rook do
  @moduledoc false

  def moves(board, {file, rank}) do
    moves_north(board, {file, rank}) ++
      moves_south(board, {file, rank}) ++
      moves_east(board, {file, rank}) ++
      moves_west(board, {file, rank})
  end

  defp moves_north(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> _moves(board, {file, rank}, {0, +1})
  end

  defp moves_south(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> _moves(board, {file, rank}, {0, -1})
  end

  defp moves_east(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> _moves(board, {file, rank}, {+1, 0})
  end

  defp moves_west(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> _moves(board, {file, rank}, {-1, 0})
  end

  defp _moves(_colour, _board, {0, _rank}, {-1, _}), do: []
  defp _moves(_colour, _board, {_file, 0}, {_, -1}), do: []
  defp _moves(_colour, _board, {7, _rank}, {1, _}), do: []
  defp _moves(_colour, _board, {_file, 7}, {_, 1}), do: []
  defp _moves(colour, board, {file, rank}, {fv, rv}) do
    next_square = {file + fv, rank + rv}
    cond do
      can_take_piece?(colour, board, next_square) ->
        [next_square]
      obstruction?(board, next_square) ->
        []
      true ->
        [next_square | _moves(colour, board, next_square, {fv, rv})]
    end
  end

  defp can_take_piece?(colour, board, {file, rank}) do
    piece = board["#{file},#{rank}"]

    piece && piece["colour"] != colour
  end

  defp obstruction?(board, {file, rank}) do
    board
    |> Map.has_key?("#{file},#{rank}")
  end
end
