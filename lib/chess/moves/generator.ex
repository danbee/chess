defmodule Chess.Moves.Generator do
  @moduledoc false

  # Move generation for pieces that move in straight lines
  def moves(_colour, _board, {0, _rank}, {-1, _}), do: []
  def moves(_colour, _board, {_file, 0}, {_, -1}), do: []
  def moves(_colour, _board, {7, _rank}, {1, _}), do: []
  def moves(_colour, _board, {_file, 7}, {_, 1}), do: []
  def moves(colour, board, {file, rank}, {fv, rv}) do
    next_square = {file + fv, rank + rv}
    cond do
      can_capture_piece?(colour, board, next_square) ->
        [next_square]
      obstruction?(colour, board, next_square) ->
        []
      true ->
        [next_square | moves(colour, board, next_square, {fv, rv})]
    end
  end

  # Move generation for pieces that follow a pattern
  def moves(_colour, _board, {_file, _rank}, []), do: []
  def moves(colour, board, {file, rank}, [{fv, rv} | moves]) do
    move_square = {file + fv, rank + rv}
    cond do
      outside_board?(move_square) ||
        obstruction?(colour, board, move_square) ->
        moves(colour, board, {file, rank}, moves)
      can_capture_piece?(colour, board, move_square) ->
        [move_square | moves(colour, board, {file, rank}, moves)]
      true ->
        [move_square | moves(colour, board, {file, rank}, moves)]
    end
  end

  defp outside_board?({file, rank}) do
    file < 0 || file > 7 ||
      rank < 0 || rank > 7
  end

  defp can_capture_piece?(colour, board, {file, rank}) do
    piece = board["#{file},#{rank}"]
    piece && piece["colour"] != colour
  end

  defp obstruction?(colour, board, {file, rank}) do
    piece = board["#{file},#{rank}"]
    piece && piece["colour"] == colour
  end
end
