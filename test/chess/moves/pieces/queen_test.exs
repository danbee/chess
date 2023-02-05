defmodule Chess.Moves.Pieces.QueenTest do
  use Chess.DataCase

  alias Chess.Moves

  test "queens can move in any direction" do
    board = %{"4,5" => %{"type" => "queen", "colour" => "white"}}
    moves = Moves.available(board, {4, 5})

    expected_moves =
      Enum.sort([
        {4, 0},
        {4, 1},
        {4, 2},
        {4, 3},
        {4, 4},
        {4, 6},
        {4, 7},
        {0, 5},
        {1, 5},
        {2, 5},
        {3, 5},
        {5, 5},
        {6, 5},
        {7, 5},
        {0, 1},
        {1, 2},
        {2, 3},
        {3, 4},
        {5, 6},
        {6, 7},
        {2, 7},
        {3, 6},
        {5, 4},
        {6, 3},
        {7, 2}
      ])

    assert Enum.sort(moves) == expected_moves
  end

  test "queens are blocked by another piece of the same colour" do
    board = %{
      "0,0" => %{"type" => "queen", "colour" => "white"},
      "0,5" => %{"type" => "king", "colour" => "white"},
      "5,0" => %{"type" => "bishop", "colour" => "white"}
    }

    moves = Moves.available(board, {0, 0})

    expected_moves =
      Enum.sort([
        {0, 1},
        {0, 2},
        {0, 3},
        {0, 4},
        {1, 0},
        {2, 0},
        {3, 0},
        {4, 0},
        {1, 1},
        {2, 2},
        {3, 3},
        {4, 4},
        {5, 5},
        {6, 6},
        {7, 7}
      ])

    assert Enum.sort(moves) == expected_moves
  end

  test "queens can take an opponents piece" do
    board = %{
      "0,0" => %{"type" => "queen", "colour" => "white"},
      "0,5" => %{"type" => "knight", "colour" => "black"},
      "5,0" => %{"type" => "rook", "colour" => "black"}
    }

    moves = Moves.available(board, {0, 0})

    expected_moves =
      Enum.sort([
        {0, 1},
        {0, 2},
        {0, 3},
        {0, 4},
        {0, 5},
        {1, 0},
        {2, 0},
        {3, 0},
        {4, 0},
        {5, 0},
        {1, 1},
        {2, 2},
        {3, 3},
        {4, 4},
        {5, 5},
        {6, 6},
        {7, 7}
      ])

    assert Enum.sort(moves) == expected_moves
  end

  def board do
    Chess.Board.default()
  end
end
