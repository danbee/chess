defmodule Chess.Moves.KnightTest do
  use Chess.DataCase

  alias Chess.Moves

  test "knights move in an L shape" do
    board = %{"4,5" => %{"type" => "knight", "colour" => "white"}}
    moves = Moves.available(board, {4, 5})

    expected_moves = Enum.sort([
      {3, 7}, {5, 7}, {6, 6}, {6, 4}, {5, 3}, {3, 3}, {2, 4}, {2, 6},
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

  test "knights are blocked by other pieces of the same colour" do
    board = %{
      "0,0" => %{"type" => "knight", "colour" => "white"},
      "1,2" => %{"type" => "king", "colour" => "white"},
    }
    moves = Moves.available(board, {0, 0})

    expected_moves = Enum.sort([
      {2, 1},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  def board do
    Chess.Board.default
  end
end
