defmodule Chess.GameTest do
  @moduledoc false

  use Chess.DataCase

  alias Chess.Game

  test "recognise when the king is in check" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "4,7" => %{"type" => "queen", "colour" => "black"},
    }

    assert Game.king_in_check?(board, "white")
  end

  test "recognise when the king is not in check" do
    board = %{
      "5,0" => %{"type" => "king", "colour" => "white"},
      "4,7" => %{"type" => "queen", "colour" => "black"},
    }

    refute Game.king_in_check?(board, "white")
  end

  test "recognize when the king is in check by a knight" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "3,2" => %{"type" => "knight", "colour" => "black"},
    }

    assert Game.king_in_check?(board, "white")
  end

  test "recognize when the king is in check by a pawn" do
    board = %{
      "4,0" => %{"type" => "king", "colour" => "white"},
      "3,1" => %{"type" => "pawn", "colour" => "black"},
    }

    assert Game.king_in_check?(board, "white")
  end
end
