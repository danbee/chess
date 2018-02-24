defmodule Chess.Store.Game do
  @moduledoc false

  use Ecto.Schema
  use Timex.Ecto.Timestamps

  import Ecto.Changeset
  import Ecto.Query

  alias Chess.Board
  alias Chess.Store.Game

  schema "games" do
    field :board, :map
    field :turn, :string

    belongs_to :user, Chess.Auth.User
    belongs_to :opponent, Chess.Auth.User, references: :id

    timestamps()
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_attrs())
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:opponent_id)
    |> put_change(:board, Board.default())
    |> put_change(:turn, default_turn())
    |> validate_required(required_attrs())
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_attrs())
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:opponent_id)
    |> validate_required(required_attrs())
  end

  def change_turn(turn) do
    case turn do
      "white" -> "black"
      "black" -> "white"
    end
  end

  def for_user(user) do
    from game in Game,
      where: game.user_id == ^user.id,
      or_where: game.opponent_id == ^user.id
  end

  def ordered(query) do
    query
    |> order_by([game], desc: game.inserted_at)
  end

  defp required_attrs, do: ~w[board turn user_id opponent_id]a

  defp default_turn do
    "white"
  end
end
