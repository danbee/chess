defmodule Chess.Moves.Pieces.King do
  @moduledoc false

  alias Chess.Moves.Generator
  alias Chess.Moves.Pieces.King.Castling

  def moves(board, {file, rank}, move_list) do
    Generator.moves(board, {file, rank}, pattern()) ++
      Castling.moves(board, {file, rank}, move_list)
  end

  defp pattern do
    [{1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}, {-1, 0}, {-1, 1}, {0, 1}]
  end
end
