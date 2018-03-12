defmodule Chess.Moves do
  @moduledoc false

  alias Chess.Moves.Pawn

  def available(board, {file, rank}) do
    piece = board["#{file},#{rank}"]

    case piece do
      %{"type" => "pawn"} ->
        Pawn.moves(board, {file, rank})
    end
  end
end
