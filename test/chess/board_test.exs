defmodule Chess.BoardTest do
  @moduledoc false

  use Chess.DataCase

  alias Chess.Board

  test "returns a piece from the board" do
    board = Board.default

    expected_piece = %{"type" => "pawn", "colour" => "white"}
    assert Board.piece(board, {4, 1}) == expected_piece
  end

  test "finds pieces on the board" do
    board = Board.default

    piece = %{"type" => "pawn", "colour" => "white"}
    expected_result = [
      {0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}, {7, 1},
    ]
    assert Board.search(board, piece) == expected_result
  end

  test "finds pieces on the board with a partial search" do
    board = Board.default

    piece = %{"colour" => "white"}
    expected_result = [
      {0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}, {5, 1}, {6, 1}, {7, 1},
      {0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}, {7, 0},
    ] |> Enum.sort
    assert Board.search(board, piece) == expected_result
  end

  test "finds a single piece on the board" do
    board = Board.default

    piece = %{"type" => "king", "colour" => "black"}
    assert Board.search(board, piece) == [{4, 7}]
  end

  test "moves a piece" do
    board = %{
      "3,0" => %{"type" => "queen", "colour" => "white"},
    }

    %{board: new_board} =
      Board.move_piece(board, %{"from" => ["3", "0"], "to" => ["5", "2"]})

    assert new_board == %{
      "5,2" => %{"type" => "queen", "colour" => "white"},
    }
  end
end
