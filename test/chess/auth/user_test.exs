defmodule Chess.UserTest do
  use Chess.DataCase

  describe "user" do
    alias Chess.Auth.User

    @valid_attrs %{username: "zelda", password: "password"}
    @invalid_attrs %{}

    test "changeset with valid attributes" do
      changeset = User.changeset(%User{}, @valid_attrs)
      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = User.changeset(%User{}, @invalid_attrs)
      refute changeset.valid?
    end

    test "username must be unique" do
      create_user("zelda")

      changeset = User.changeset(%User{}, @valid_attrs)
      refute changeset.valid?
    end

    defp create_user(username) do
      changeset = User.changeset(
        %User{},
        %{username: username, password: "password"}
      )
      Repo.insert!(changeset)
    end
  end
end
