defmodule Chess.UserTest do
  use Chess.DataCase

  import Chess.Factory, only: [create_user: 1]

  describe "user" do
    alias Chess.Auth.User
    alias Chess.Repo

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
      {:error, changeset} = Repo.insert(changeset)

      refute changeset.valid?
    end
  end
end
