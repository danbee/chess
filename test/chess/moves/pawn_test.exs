defmodule Chess.Moves.PawnTest do
  use Chess.DataCase

  alias Chess.Moves.Pawn

  test "white pawn can move forward one or two spaces" do
    moves = Pawn.moves(board(), {4, 1})

    expected_moves = [{4, 2}, {4, 3}]
    assert moves == expected_moves
  end

  test "black pawn can move forward one or two spaces" do
    moves = Pawn.moves(board(), {4, 6})

    expected_moves = [{4, 5}, {4, 4}]
    assert moves == expected_moves
  end

  test "white pawn not on starting square can move forward one space" do
    board = %{"4,2" => %{"type" => "pawn", "colour" => "white"}}
    moves = Pawn.moves(board, {4, 2})

    expected_moves = [{4, 3}]
    assert moves == expected_moves
  end

  test "black pawn not on starting square can move forward one space" do
    board = %{"4,5" => %{"type" => "pawn", "colour" => "black"}}
    moves = Pawn.moves(board, {4, 5})

    expected_moves = [{4, 4}]
    assert moves == expected_moves
  end

  def board do
    Chess.Board.default
  end
end
