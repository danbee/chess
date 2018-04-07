defmodule Chess.GameStateTest do
  @moduledoc false

  use Chess.DataCase

  alias Chess.GameState

  test "king is in check" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "4,7" => %{"type" => "queen", "colour" => "black"},
    }

    assert GameState.king_in_check?(board, "white")
  end

  test "king is not in check" do
    board = %{
      "5,0" => %{"type" => "king", "colour" => "white"},
      "4,7" => %{"type" => "queen", "colour" => "black"},
    }

    refute GameState.king_in_check?(board, "white")
  end

  test "king is in check by a knight" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "3,2" => %{"type" => "knight", "colour" => "black"},
    }

    assert GameState.king_in_check?(board, "white")
  end

  test "king is in check by a pawn" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "3,1" => %{"type" => "pawn", "colour" => "black"},
    }

    assert GameState.king_in_check?(board, "white")
  end

  test "king is in checkmate by queen and rook" do
    board = %{
      "0,0" => %{"type" => "king", "colour" => "white"},
      "0,4" => %{"type" => "queen", "colour" => "black"},
      "1,4" => %{"type" => "rook", "colour" => "black"},
    }

    assert GameState.player_checkmated?(board, "white")
  end

  test "king is not in checkmate by a queen" do
    board = %{
      "0,0" => %{"type" => "king", "colour" => "white"},
      "0,4" => %{"type" => "queen", "colour" => "black"},
    }

    refute GameState.player_checkmated?(board, "white")
  end

  test "king is checkmate by a queen and a  knight" do
    board = %{
      "0,0" => %{"type" => "king", "colour" => "white"},
      "1,1" => %{"type" => "queen", "colour" => "black"},
      "2,3" => %{"type" => "knight", "colour" => "black"},
    }

    assert GameState.player_checkmated?(board, "white")
  end

  test "knight can block checkmate by queen and rook" do
    board = %{
      "0,0" => %{"type" => "king", "colour" => "white"},
      "2,0" => %{"type" => "knight", "colour" => "white"},
      "0,5" => %{"type" => "queen", "colour" => "black"},
      "1,5" => %{"type" => "rook", "colour" => "black"},
    }

    refute GameState.player_checkmated?(board, "white")
  end

  test "bishop can take checking queen" do
    board = %{
      "0,0" => %{"type" => "king", "colour" => "white"},
      "2,3" => %{"type" => "bishop", "colour" => "white"},
      "0,5" => %{"type" => "queen", "colour" => "black"},
      "1,5" => %{"type" => "rook", "colour" => "black"},
    }

    refute GameState.player_checkmated?(board, "white")
  end

  test "game can be stalemated" do
    board = %{
      "0,0" => %{"type" => "king", "colour" => "white"},
      "1,2" => %{"type" => "rook", "colour" => "black"},
      "2,1" => %{"type" => "rook", "colour" => "black"},
    }

    assert GameState.player_stalemated?(board, "white")
  end
end
