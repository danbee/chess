defmodule Chess.Moves.Pieces.Pawn do
  @moduledoc false

  def moves(board, {file, rank}) do
    normal_moves(board, {file, rank}) ++
      capture_moves(board, {file, rank})
  end

  defp normal_moves(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> _moves(board, {file, rank})
  end

  defp capture_moves(board, {file, rank}) do
    colour =
      board["#{file},#{rank}"]
      |> Map.get("colour")

    colour
    |> _capture_moves(board, {file, rank}, pattern(colour))
  end

  def pattern("white") do
    [{-1, 1}, {1, 1}]
  end

  def pattern("black") do
    [{-1, -1}, {1, -1}]
  end

  defp _moves("white", board, {file, rank}) do
    cond do
      obstruction?(board, {file, rank + 1}) ->
        []
      rank == 1 ->
        [{file, rank + 1} | _moves("white", board, {file, rank + 1})]
      true ->
        [{file, rank + 1}]
    end
  end

  defp _moves("black", board, {file, rank}) do
    cond do
      obstruction?(board, {file, rank - 1}) ->
        []
      rank == 6 ->
        [{file, rank - 1} | _moves("black", board, {file, rank - 1})]
      true ->
        [{file, rank - 1}]
    end
  end

  def _capture_moves(_colour, _board, {_file, _rank}, []), do: []
  def _capture_moves(colour, board, {file, rank}, [{fv, rv} | moves]) do
    move_square = {file + fv, rank + rv}
    if can_capture_piece?(colour, board, move_square) do
      [move_square | _capture_moves(colour, board, {file, rank}, moves)]
    else
      _capture_moves(colour, board, {file, rank}, moves)
    end
  end

  defp can_capture_piece?(colour, board, {file, rank}) do
    piece = board["#{file},#{rank}"]
    piece && piece["colour"] != colour
  end

  defp obstruction?(board, {file, rank}) do
    board
    |> Map.has_key?("#{file},#{rank}")
  end
end
