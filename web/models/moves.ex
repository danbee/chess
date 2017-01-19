defmodule Chess.Moves do
  def available(board, square) do
    {file, rank} = square
    piece = board["#{file},#{rank}"]

    case piece do
      %{type: :pawn, colour: :white} ->
        case rank do
          1 -> [{file, rank + 1}, {file, rank + 2}]
          _ -> [{file, rank + 1}]
        end
      %{type: :pawn, colour: :black} ->
        case rank do
          6 -> [{file, rank - 1}, {file, rank - 2}]
          _ -> [{file, rank - 1}]
        end
      %{type: :rook} ->
        rook_moves(board, square)
    end
  end

  defp rook_moves(_board, square) do
    {file, rank} = square
    moves = []

    moves = cond do
      file > 0 -> moves ++ Enum.map((file - 1)..0, fn (f) -> {f, rank} end)
      true -> moves
    end
    moves = cond do
      file < 7 -> moves ++ Enum.map((file + 1)..7, fn (f) -> {f, rank} end)
      true -> moves
    end

    moves = cond do
      rank > 0 -> moves ++ Enum.map((rank - 1)..0, fn (r) -> {file, r} end)
      true -> moves
    end
    moves = cond do
      rank < 7 -> moves ++ Enum.map((rank + 1)..7, fn (r) -> {file, r} end)
      true -> moves
    end

    Enum.sort(moves)
  end
end
