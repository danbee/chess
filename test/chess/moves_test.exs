defmodule Chess.MovesTest do
  @moduledoc false

  use Chess.DataCase

  describe "moves" do
    alias Chess.Store.Move
    alias Chess.Moves

    test "tranforms a list of moves" do
      moves = [
        %Move{
          from: %{"file" => 4, "rank" => 1},
          to: %{"file" => 4, "rank" => 3},
        },
        %Move{
          from: %{"file" => 4, "rank" => 6},
          to: %{"file" => 4, "rank" => 4},
        },
        %Move{
          from: %{"file" => 1, "rank" => 0},
          to: %{"file" => 2, "rank" => 2},
        },
      ]

      expected_result = [
        ["e2-e4", "e7-e5"],
        ["b1-c3"],
      ]

      assert Moves.transform(moves) == expected_result
    end
  end
end
