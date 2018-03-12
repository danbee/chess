defmodule Chess.Moves.Pawn do
  @moduledoc false

  def moves(board, {file, rank}) do
    piece = board["#{file},#{rank}"]

    case piece do
      %{"colour" => "white"} ->
        case rank do
          1 -> [{file, rank + 1}, {file, rank + 2}]
          _ -> [{file, rank + 1}]
        end
      %{"colour" => "black"} ->
        case rank do
          6 -> [{file, rank - 1}, {file, rank - 2}]
          _ -> [{file, rank - 1}]
        end
    end
  end
end
