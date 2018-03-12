defmodule Chess.Moves.BishopTest do
  use Chess.DataCase

  alias Chess.Moves

  test "bishops can move diagonally" do
    board = %{"4,5" => %{"type" => "bishop", "colour" => "white"}}
    moves = Moves.available(board, {4, 5})

    expected_moves = Enum.sort([
      {0, 1}, {1, 2}, {2, 3}, {3, 4}, {5, 6}, {6, 7},
      {2, 7}, {3, 6}, {5, 4}, {6, 3}, {7, 2},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "bishops cannot move further than the edge" do
    board = %{"0,0" => %{"type" => "bishop", "colour" => "white"}}
    moves = Moves.available(board, {0, 0})

    expected_moves = Enum.sort([
      {1, 1}, {2, 2}, {3, 3}, {4, 4}, {5, 5}, {6, 6}, {7, 7}
    ])
    assert Enum.sort(moves) == expected_moves
  end

  def board do
    Chess.Board.default
  end
end
