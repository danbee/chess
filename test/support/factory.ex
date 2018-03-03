defmodule Chess.Factory do
  @moduledoc false

  alias Chess.Auth.User
  alias Chess.Store.Game
  alias Chess.Repo

  def insert(_resource, _params \\ %{})

  def insert(:user, params) do
    attrs = %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ilovelink"
    }
    |> Map.merge(params)

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert!
  end

  def insert(:game, params) do
    %Game{}
    |> Game.changeset(params)
    |> Repo.insert!
  end
end
