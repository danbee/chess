defmodule Chess.Moves.Generator do
  @moduledoc false

  def moves(_colour, _board, {0, _rank}, {-1, _}), do: []
  def moves(_colour, _board, {_file, 0}, {_, -1}), do: []
  def moves(_colour, _board, {7, _rank}, {1, _}), do: []
  def moves(_colour, _board, {_file, 7}, {_, 1}), do: []
  def moves(colour, board, {file, rank}, {fv, rv}) do
    next_square = {file + fv, rank + rv}
    cond do
      can_take_piece?(colour, board, next_square) ->
        [next_square]
      obstruction?(board, next_square) ->
        []
      true ->
        [next_square | moves(colour, board, next_square, {fv, rv})]
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
