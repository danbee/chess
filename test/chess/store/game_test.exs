defmodule Chess.GameTest do
  @moduledoc false

  use Chess.DataCase

  describe "game" do
    alias Chess.Repo
    alias Chess.Store.Game

    import Chess.Factory

    test "game is valid with a board and user" do
      user = insert(:user, %{email: "link@hyrule.com"})
      opponent = insert(:user, %{email: "zelda@hyrule.com"})

      attrs = %{
        board: %{},
        user_id: user.id,
        opponent_id: opponent.id,
        turn: "white"
      }
      changeset = Game.changeset(%Game{}, attrs)

      assert changeset.valid?
      assert {:ok, _game} = Repo.insert(changeset)
    end

    test "game cannot be saved if the user or opponent do not exist" do
      attrs = %{
        board: %{},
        user_id: 1,
        opponent_id: 2,
        turn: "white"
      }
      changeset = Game.changeset(%Game{}, attrs)

      assert changeset.valid?
      assert {:error, _changeset} = Repo.insert(changeset)
    end

    test "game is invalid without a board" do
      user = insert(:user, %{email: "link@hyrule.com"})
      opponent = insert(:user, %{email: "zelda@hyrule.com"})

      attrs = %{board: nil, user_id: user.id, opponent_id: opponent.id}
      changeset = Game.changeset(%Game{}, attrs)

      refute changeset.valid?
      assert {:error, _changeset} = Repo.insert(changeset)
    end

    test "game is invalid without a user" do
      opponent = insert(:user, %{email: "zelda@hyrule.com"})

      attrs = %{board: %{}, opponent_id: opponent.id}
      changeset = Game.changeset(%Game{}, attrs)

      refute changeset.valid?
      assert {:error, _changeset} = Repo.insert(changeset)
    end

    test "game is invalid without an opponent" do
      user = insert(:user, %{email: "link@hyrule.com"})

      attrs = %{board: %{}, user_id: user.id}
      changeset = Game.changeset(%Game{}, attrs)

      refute changeset.valid?
      assert {:error, _changeset} = Repo.insert(changeset)
    end

    test "game is invalid without anything" do
      changeset = Game.changeset(%Game{}, %{})

      refute changeset.valid?
      assert {:error, _changeset} = Repo.insert(changeset)
    end
  end
end
