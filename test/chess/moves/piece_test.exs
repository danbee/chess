defmodule Chess.Moves.PieceTest do
  use Chess.DataCase

  alias Chess.Moves.Piece

  test "piece is not being attacked" do
    board = %{
      "4,5" => %{"type" => "king", "colour" => "white"},
      "2,1" => %{"type" => "rook", "colour" => "black"},
    }

    refute Piece.attacked?(board, {4, 5})
  end

  test "piece can be attacked by a rook" do
    board = %{
      "4,5" => %{"type" => "king", "colour" => "white"},
      "2,5" => %{"type" => "rook", "colour" => "black"},
    }

    assert Piece.attacked?(board, {4, 5})
  end

  test "piece can be attacked by a bishop" do
    board = %{
      "4,5" => %{"type" => "king", "colour" => "white"},
      "6,7" => %{"type" => "bishop", "colour" => "black"},
    }

    assert Piece.attacked?(board, {4, 5})
  end

  test "piece can be attacked by a queen" do
    board = %{
      "4,5" => %{"type" => "king", "colour" => "white"},
      "6,7" => %{"type" => "queen", "colour" => "black"},
    }

    assert Piece.attacked?(board, {4, 5})
  end

  test "piece is not attacked by a knight" do
    board = %{
      "4,5" => %{"type" => "king", "colour" => "white"},
      "7,7" => %{"type" => "knight", "colour" => "black"},
    }

    refute Piece.attacked?(board, {4, 5})
  end

  test "piece can be attacked by a knight" do
    board = %{
      "4,5" => %{"type" => "king", "colour" => "white"},
      "5,7" => %{"type" => "knight", "colour" => "black"},
    }

    assert Piece.attacked?(board, {4, 5})
  end
end
