defmodule Chess.Factory do
  alias Chess.Auth.User
  alias Chess.Repo

  def create_user do
    User.changeset(
      %User{},
      %{username: "link@hyrule.kingdom", password: "ilovezelda"}
    )
    |> Repo.insert!
  end
end
