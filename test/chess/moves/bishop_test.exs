defmodule Chess.Moves.BishopTest do
  use Chess.DataCase

  alias Chess.Moves.Bishop

  test "bishops can move diagonally" do
    board = %{"4,5" => %{"type" => "bishop", "colour" => "white"}}
    moves = Bishop.moves(board, {4, 5})

    expected_moves = Enum.sort([
      {5, 6}, {6, 7},
      {5, 4}, {6, 3}, {7, 2},
      {3, 4}, {2, 3}, {1, 2}, {0, 1},
      {3, 6}, {2, 7},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "bishops cannot move further than the edge" do
    board = %{"0,0" => %{"type" => "bishop", "colour" => "white"}}
    moves = Bishop.moves(board, {0, 0})

    expected_moves = Enum.sort([
      {1, 1}, {2, 2}, {3, 3}, {4, 4}, {5, 5}, {6, 6}, {7, 7}
    ])
    assert Enum.sort(moves) == expected_moves
  end

  def board do
    Chess.Board.default
  end
end
