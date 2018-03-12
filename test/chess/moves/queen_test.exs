defmodule Chess.Moves.QueenTest do
  use Chess.DataCase

  alias Chess.Moves.Queen

  test "queens can move in any direction" do
    board = %{"4,5" => %{"type" => "rook", "colour" => "white"}}
    moves = Queen.moves(board, {4, 5})

    expected_moves = Enum.sort([
      {4, 0}, {4, 1}, {4, 2}, {4, 3}, {4, 4}, {4, 6}, {4, 7},
      {0, 5}, {1, 5}, {2, 5}, {3, 5}, {5, 5}, {6, 5}, {7, 5},
      {5, 6}, {6, 7},
      {5, 4}, {6, 3}, {7, 2},
      {3, 4}, {2, 3}, {1, 2}, {0, 1},
      {3, 6}, {2, 7},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  def board do
    Chess.Board.default
  end
end
