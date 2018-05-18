defmodule Chess.Moves.Pieces.King.CastlingTest do
  use Chess.DataCase

  alias Chess.Moves
  alias Chess.Store.Move

  test "king can move two spaces to castle with the king side rook" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "7,0" => %{"type" => "rook", "colour" => "white"},
    }
    moves = Moves.available(board, {4, 0})

    expected_moves = Enum.sort([
      {3, 0}, {5, 0}, {3, 1}, {4, 1}, {5, 1},
      {6, 0},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "king can move two spaces to castle with the queen side rook" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "0,0" => %{"type" => "rook", "colour" => "white"},
    }
    moves = Moves.available(board, {4, 0})

    expected_moves = Enum.sort([
      {3, 0}, {5, 0}, {3, 1}, {4, 1}, {5, 1},
      {2, 0},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "cannot castle if a piece is in the way" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "3,0" => %{"type" => "queen", "colour" => "white"},
      "0,0" => %{"type" => "rook", "colour" => "white"},
    }
    moves = Moves.available(board, {4, 0})

    expected_moves = Enum.sort([
      {5, 0}, {3, 1}, {4, 1}, {5, 1},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "cannot castle if it would result in the king being in check" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "0,0" => %{"type" => "rook", "colour" => "white"},
      "2,7" => %{"type" => "queen", "colour" => "black"},
    }
    moves = Moves.available(board, {4, 0})

    expected_moves = Enum.sort([
      {3, 0}, {5, 0}, {3, 1}, {4, 1}, {5, 1},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "cannot castle if the king moves through a space that is attacked" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "0,0" => %{"type" => "rook", "colour" => "white"},
      "3,7" => %{"type" => "queen", "colour" => "black"},
    }
    moves = Moves.available(board, {4, 0})

    expected_moves = Enum.sort([
      {3, 0}, {5, 0}, {3, 1}, {4, 1}, {5, 1},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "cannot castle if the king has moved" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "0,0" => %{"type" => "rook", "colour" => "white"},
    }
    move_list = [
      %Move{
        from: %{"file" => 4, "rank" => 0},
        to: %{"file" => 4, "rank" => 1},
        piece: %{"type" => "king",   "colour" => "white"}
      },
      %Move{
        from: %{"file" => 4, "rank" => 1},
        to: %{"file" => 4, "rank" => 0},
        piece: %{"type" => "king",   "colour" => "white"}
      },
    ]
    moves = Moves.available(board, {4, 0}, move_list)

    expected_moves = Enum.sort([
      {3, 0}, {5, 0}, {3, 1}, {4, 1}, {5, 1},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "cannot castle if the queen side rook has moved" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "0,0" => %{"type" => "rook", "colour" => "white"},
    }
    move_list = [
      %Move{
        from: %{"file" => 0, "rank" => 0},
        to: %{"file" => 0, "rank" => 1},
        piece: %{"type" => "rook",   "colour" => "white"}
      },
      %Move{
        from: %{"file" => 0, "rank" => 1},
        to: %{"file" => 0, "rank" => 0},
        piece: %{"type" => "rook",   "colour" => "white"}
      },
    ]
    moves = Moves.available(board, {4, 0}, move_list)

    expected_moves = Enum.sort([
      {3, 0}, {5, 0}, {3, 1}, {4, 1}, {5, 1},
    ])
    assert Enum.sort(moves) == expected_moves
  end

  test "cannot castle if the king side rook has moved" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "7,0" => %{"type" => "rook", "colour" => "white"},
    }
    move_list = [
      %Move{
        from: %{"file" => 7, "rank" => 0},
        to: %{"file" => 7, "rank" => 1},
        piece: %{"type" => "rook",   "colour" => "white"}
      },
      %Move{
        from: %{"file" => 7, "rank" => 1},
        to: %{"file" => 7, "rank" => 0},
        piece: %{"type" => "rook",   "colour" => "white"}
      },
    ]
    moves = Moves.available(board, {4, 0}, move_list)

    expected_moves = Enum.sort([
      {3, 0}, {5, 0}, {3, 1}, {4, 1}, {5, 1},
    ])
    assert Enum.sort(moves) == expected_moves
  end
end
