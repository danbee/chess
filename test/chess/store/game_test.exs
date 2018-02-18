defmodule Chess.GameTest do
  use Chess.DataCase

  describe "game" do
    alias Chess.Store.Game

    test "game is valid with a board and user" do
      attrs = %{board: %{}, user_id: 1, opponent_id: 2}
      changeset = Game.changeset(%Game{}, attrs)

      assert changeset.valid?
    end

    test "game is invalid without a board" do
      attrs = %{user_id: 1, opponent_id: 2}
      changeset = Game.changeset(%Game{}, attrs)

      refute changeset.valid?
    end

    test "game is invalid without a user" do
      attrs = %{board: %{}, opponent_id: 2}
      changeset = Game.changeset(%Game{}, attrs)

      refute changeset.valid?
    end

    test "game is invalid without an opponent" do
      attrs = %{board: %{}, user_id: 1}
      changeset = Game.changeset(%Game{}, attrs)

      refute changeset.valid?
    end

    test "game is invalid without anything" do
      changeset = Game.changeset(%Game{}, %{})

      refute changeset.valid?
    end
  end
end
