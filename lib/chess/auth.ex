defmodule Chess.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Chess.Repo

  alias Chess.Store.User

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc false
  def authenticate_user(email, password) do
    query =
      from(u in User,
        where: u.email == ^email
      )

    query
    |> Repo.one()
    |> Argon2.check_pass(password)
  end
end
