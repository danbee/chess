defmodule Chess.Factory do
  alias Chess.Auth.User
  alias Chess.Store.Game
  alias Chess.Repo

  def create_user(username \\ "zelda", password \\ "password") do
    User.changeset(
      %User{},
      %{username: username, password: password}
    )
    |> Repo.insert!
  end

  def create_game_for(user) do
    Game.create_changeset(
      %Game{},
      %{user_id: user.id}
    )
    |> Repo.insert!
  end
end
