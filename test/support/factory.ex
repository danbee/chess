defmodule Chess.Factory do
  alias Chess.Auth.User
  alias Chess.Repo

  def create_user(username \\ "zelda", password \\ "password") do
    User.changeset(
      %User{},
      %{username: username, password: password}
    )
    |> Repo.insert!
  end
end
