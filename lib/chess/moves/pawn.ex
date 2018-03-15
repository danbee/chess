defmodule Chess.Moves.Pawn do
  @moduledoc false

  def moves(board, {file, rank}) do
    normal_moves(board, {file, rank}) ++
      taking_moves(board, {file, rank})
  end

  defp normal_moves(board, {file, rank}) do
    board["#{file},#{rank}"]
    |> Map.get("colour")
    |> _moves(board, {file, rank})
  end

  defp taking_moves(board, {file, rank}) do
    colour =
      board["#{file},#{rank}"]
      |> Map.get("colour")

    colour
    |> _taking_moves(board, {file, rank}, patterns(colour))
  end

  defp patterns("white") do
    [{-1, 1}, {1, 1}]
  end

  defp patterns("black") do
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

  def _taking_moves(_colour, _board, {_file, _rank}, []), do: []
  def _taking_moves(colour, board, {file, rank}, [{fv, rv} | moves]) do
    move_square = {file + fv, rank + rv}
    if can_take_piece?(colour, board, move_square) do
      [move_square | _taking_moves(colour, board, {file, rank}, moves)]
    else
      _taking_moves(colour, board, {file, rank}, moves)
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
