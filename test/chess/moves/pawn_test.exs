defmodule Chess.Moves.PawnTest do
  use Chess.DataCase

  alias Chess.Moves.Pawn

  test "white pawn can move forward one or two spaces" do
    moves = Pawn.moves(default_board(), {4, 1})

    expected_moves = [{4, 2}, {4, 3}]
    assert moves == expected_moves
  end

  test "black pawn can move forward one or two spaces" do
    moves = Pawn.moves(default_board(), {4, 6})

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

  test "pawn is blocked from moving two squares by another piece" do
    board = %{
      "4,1" => %{"type" => "pawn", "colour" => "white"},
      "4,3" => %{"type" => "pawn", "colour" => "black"},
    }
    moves = Pawn.moves(board, {4, 1})

    expected_moves = [{4, 2}]
    assert moves == expected_moves
  end

  test "pawn is blocked from moving one or two squares by another piece" do
    board = %{
      "4,1" => %{"type" => "pawn", "colour" => "white"},
      "4,2" => %{"type" => "pawn", "colour" => "black"},
    }
    moves = Pawn.moves(board, {4, 1})

    expected_moves = []
    assert moves == expected_moves
  end

  test "pawn is blocked from moving one square by another piece" do
    board = %{
      "4,2" => %{"type" => "pawn", "colour" => "white"},
      "4,3" => %{"type" => "pawn", "colour" => "black"},
    }
    moves = Pawn.moves(board, {4, 2})

    expected_moves = []
    assert moves == expected_moves
  end

  test "white pawn can take an opponents piece" do
    board = %{
      "4,2" => %{"type" => "pawn", "colour" => "white"},
      "5,3" => %{"type" => "pawn", "colour" => "black"},
    }
    moves = Pawn.moves(board, {4, 2})

    expected_moves = [{4, 3}, {5, 3}]
    assert moves == expected_moves
  end

  test "black pawn can take an opponents piece" do
    board = %{
      "6,6" => %{"type" => "pawn", "colour" => "black"},
      "5,5" => %{"type" => "pawn", "colour" => "white"},
    }
    moves = Pawn.moves(board, {6, 6})

    expected_moves = [{6, 5}, {6, 4}, {5, 5}]
    assert moves == expected_moves
  end

  def default_board do
    Chess.Board.default
  end
end
