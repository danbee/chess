defmodule Chess.MovesTest do
  use Chess.ModelCase

  alias Chess.Moves

  test "white pawn can move forward one or two spaces" do
    moves = Moves.available(board(), {4, 1})

    expected_moves = [{4, 2}, {4, 3}]
    assert moves == expected_moves
  end

  test "black pawn can move forward one or two spaces" do
    moves = Moves.available(board(), {4, 6})

    expected_moves = [{4, 5}, {4, 4}]
    assert moves == expected_moves
  end

  test "white pawn not on starting square can move forward one space" do
    board = %{ "4,2" => %{type: :pawn, colour: :white} }
    moves = Moves.available(board, {4, 2})

    expected_moves = [{4, 3}]
    assert moves == expected_moves
  end

  test "black pawn not on starting square can move forward one space" do
    board = %{ "4,5" => %{type: :pawn, colour: :black} }
    moves = Moves.available(board, {4, 5})

    expected_moves = [{4, 4}]
    assert moves == expected_moves
  end

  def board do
    Chess.Board.default
  end
end
