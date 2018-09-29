defmodule Chess.Repo.QueriesTest do
  use Chess.DataCase

  import Chess.Factory
  alias Chess.Repo
  alias Chess.Repo.Queries

  describe "opponents" do
    test "it finds a user on a partial name match" do
      user = insert(:user, %{
        name: "Link",
        email: "link@hyrule.com",
        password: "ilovezelda"
      })
      opponent = insert(:user, %{
        name: "Princess Zelda",
        email: "zelda@hyrule.com",
        password: "ganonsucks"
      })

      result =
        user
        |> Queries.opponents("zelda")
        |> Repo.one

      assert result.id == opponent.id
    end

    test "it finds a user on a complete email match" do
      user = insert(:user, %{
        name: "Link",
        email: "link@hyrule.com",
        password: "ilovezelda"
      })
      opponent = insert(:user, %{
        name: "Princess Zelda",
        email: "zelda@hyrule.com",
        password: "ganonsucks"
      })

      result =
        user
        |> Queries.opponents("zelda@hyrule.com")
        |> Repo.one

      assert result.id == opponent.id
    end

    test "it does not find a user on a partial email" do
      user = insert(:user, %{
        name: "Link",
        email: "link@hyrule.com",
        password: "ilovezelda"
      })
      insert(:user, %{
        name: "Princess Zelda",
        email: "zelda@hyrule.com",
        password: "ganonsucks"
      })

      result =
        user
        |> Queries.opponents("hyrule")
        |> Repo.one

      assert result == nil
    end
  end
end
