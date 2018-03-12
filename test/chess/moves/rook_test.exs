defmodule Chess.Moves.RookTest do
  use Chess.DataCase

  alias Chess.Moves

  test "rooks can move horizontally or vertically" do
    board = %{"4,5" => %{"type" => "rook", "colour" => "white"}}
    moves = Moves.available(board, {4, 5})

    expected_moves = Enum.sort([
      {4, 0}, {4, 1}, {4, 2}, {4, 3}, {4, 4}, {4, 6}, {4, 7},
      {0, 5}, {1, 5}, {2, 5}, {3, 5}, {5, 5}, {6, 5}, {7, 5},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "rook cannot move further than the edge" do
    board = %{"0,0" => %{"type" => "rook", "colour" => "white"}}
    moves = Moves.available(board, {0, 0})

    expected_moves = Enum.sort([
      {0, 1}, {0, 2}, {0, 3}, {0, 4}, {0, 5}, {0, 6}, {0, 7},
      {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}, {7, 0},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  def board do
    Chess.Board.default
  end
end
