defmodule Chess.MoveListTest do
  @moduledoc false

  use Chess.DataCase

  describe "moves" do
    alias Chess.Store.Move
    alias Chess.MoveList

    test "tranforms a list of moves" do
      moves = [
        %Move{
          piece: %{"type" => "pawn", "colour" => "white"},
          from: %{"file" => 4, "rank" => 1},
          to: %{"file" => 4, "rank" => 3},
        },
        %Move{
          piece: %{"type" => "pawn", "colour" => "black"},
          from: %{"file" => 4, "rank" => 6},
          to: %{"file" => 4, "rank" => 4},
        },
        %Move{
          piece: %{"type" => "knight", "colour" => "white"},
          from: %{"file" => 1, "rank" => 0},
          to: %{"file" => 2, "rank" => 2},
        },
      ]

      expected_result = [
        [
          %{
            id: nil,
            piece: %{"type" => "pawn", "colour" => "white"},
            from: "e2",
            to: "e4"
          },
          %{
            id: nil,
            piece: %{"type" => "pawn", "colour" => "black"},
            from: "e7",
            to: "e5"
          }
        ],
        [
          %{
            id: nil,
            piece: %{"type" => "knight", "colour" => "white"},
            from: "b1",
            to: "c3"
          }
        ],
      ]

      assert MoveList.transform(moves) == expected_result
    end
  end
end
