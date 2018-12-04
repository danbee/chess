defmodule Chess.Store.MoveTest do
  @moduledoc false

  use Chess.DataCase

  import Chess.Factory

  alias Chess.Board
  alias Chess.Repo
  alias Chess.Store.Move

  describe "move" do
    test "move is valid with a game, a from, and a to" do
      user = insert(:user)
      opponent = insert(:opponent)

      game = insert(:game, %{
        board: Board.default,
        user_id: user.id,
        opponent_id: opponent.id,
      })

      changeset = Move.changeset(%Move{}, %{
        game_id: game.id,
        from: %{"file" => 4, "rank" => 1},
        to: %{"file" => 4, "rank" => 3},
        piece: %{"type" => "pawn", "colour" => "white"},
      })

      assert changeset.valid?
      assert {:ok, _move} = Repo.insert(changeset)
    end

    test "move is invalid without a game" do
      changeset = Move.changeset(%Move{}, %{
        from: %{"file" => 4, "rank" => 1},
        to: %{"file" => 4, "rank" => 3},
        piece: %{"type" => "pawn", "colour" => "white"},
      })

      refute changeset.valid?
    end

    test "move is invalid without a from or to" do
      user = insert(:user)
      opponent = insert(:opponent)

      game = insert(:game, %{
        board: Board.default,
        user_id: user.id,
        opponent_id: opponent.id,
      })

      changeset = Move.changeset(%Move{}, %{
        game_id: game.id,
        piece: %{"type" => "pawn", "colour" => "white"},
      })

      refute changeset.valid?
    end

    test "move is invalid without a piece" do
      user = insert(:user)
      opponent = insert(:opponent)

      game = insert(:game, %{
        board: Board.default,
        user_id: user.id,
        opponent_id: opponent.id,
      })

      changeset = Move.changeset(%Move{}, %{
        game_id: game.id,
        from: %{"file" => 4, "rank" => 1},
        to: %{"file" => 4, "rank" => 3},
      })

      refute changeset.valid?
    end

    test "translates a move" do
      move = %Move{
        piece: %{"type" => "pawn", "colour" => "white"},
        piece_captured: %{"type" => "pawn", "colour" => "black"},
        from: %{"file" => 4, "rank" => 1},
        to: %{"file" => 4, "rank" => 3},
      }

      assert Move.transform(move) == %{
        id: nil,
        piece: %{"type" => "pawn", "colour" => "white"},
        from: "e2",
        to: "e4"
      }
    end
  end
end
