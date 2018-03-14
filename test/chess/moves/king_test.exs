defmodule Chess.Moves.KingTest do
  use Chess.DataCase

  alias Chess.Moves

  test "kings can move one square in any direction" do
    board = %{"4,5" => %{"type" => "king", "colour" => "white"}}
    moves = Moves.available(board, {4, 5})

    expected_moves = Enum.sort([
      {3, 4}, {4, 4}, {5, 4}, {5, 5}, {5, 6}, {4, 6}, {3, 6}, {3, 5},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "knights cannot move beyond the edges of the board" do
    board = %{"0,0" => %{"type" => "knight", "colour" => "white"}}
    moves = Moves.available(board, {0, 0})

    expected_moves = Enum.sort([
      {1, 2}, {2, 1}
    ])
    assert Enum.sort(moves) == expected_moves
  end

  def board do
    Chess.Board.default
  end
end