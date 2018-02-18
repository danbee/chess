defmodule Chess.Auth.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Argon2

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    has_many :games, Chess.Store.Game
    has_many :other_games, Chess.Store.Game, foreign_key: :opponent_id

    timestamps()
  end

  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> hash_password()
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      changeset
      |> change(Argon2.add_hash(password))
    else
      changeset
    end
  end
end
