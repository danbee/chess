defmodule Chess.Factory do
  @moduledoc false

  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Repo

  def insert(_resource, _params \\ %{})

  def insert(:user, new_params) do
    params =
      %{
        name: "Link",
        email: "link@hyrule.com",
        password: "ilovezelda"
      }
      |> Map.merge(new_params)

    %User{}
    |> User.changeset(params)
    |> Repo.insert!
  end

  def insert(:opponent, new_params) do
    params =
      %{
        name: "Zelda",
        email: "zelda@hyrule.com",
        password: "ganonsucks"
      }
      |> Map.merge(new_params)

    %User{}
    |> User.changeset(params)
    |> Repo.insert!
  end

  def insert(:game, params) do
    %Game{}
    |> Game.changeset(params)
    |> Repo.insert!
  end
end
