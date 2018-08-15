defmodule Chess.Factory do
  @moduledoc false

  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Repo

  def insert(_resource, _params \\ %{})

  def insert(:user, params) do
    %User{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    }
    |> User.changeset(params)
    |> Repo.insert!
  end

  def insert(:opponent, params) do
    %User{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    }
    |> User.changeset(params)
    |> Repo.insert!
  end

  def insert(:game, params) do
    %Game{}
    |> Game.changeset(params)
    |> Repo.insert!
  end
end
