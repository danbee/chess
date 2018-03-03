defmodule Chess.Auth.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Argon2

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :games, Chess.Store.Game
    has_many :games_as_opponent, Chess.Store.Game, foreign_key: :opponent_id

    timestamps()
  end

  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_attrs())
    |> validate_required(required_attrs())
    |> unique_constraint(:email)
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

  defp required_attrs, do: ~w[name email password]a
end
