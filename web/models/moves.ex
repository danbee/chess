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
        []
    end
  end
end
