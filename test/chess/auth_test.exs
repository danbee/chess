defmodule Chess.AuthTest do
  use Chess.DataCase

  alias Chess.Auth

  describe "users" do
    alias Chess.Auth.User

    @valid_attrs %{name: "some name", password: "some password", username: "some username"}
    @update_attrs %{name: "some name", password: "some updated password", username: "some updated username"}
    @invalid_attrs %{name: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Auth.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Auth.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert user == Auth.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end

    test "authenticate_user/1 returns false on incorrect password " do
      user_fixture(username: "link", password: "eyeofsheikah")
      assert {:error, message} = Auth.authenticate_user("link", "shadowtemple")
      assert message == "invalid password"
    end

    test "authenticate_user/1 returns true on correct password " do
      user = user_fixture(username: "link", password: "eyeofsheikah")
      assert {:ok, ^user} = Auth.authenticate_user("link", "eyeofsheikah")
    end
  end
end
