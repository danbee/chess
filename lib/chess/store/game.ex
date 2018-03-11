defmodule Chess.Store.Game do
  @moduledoc false

  use Ecto.Schema
  use Timex.Ecto.Timestamps

  import Ecto.Changeset
  import Ecto.Query

  alias Chess.Board
  alias Chess.Store.Game

  schema "games" do
    field :board, :map, default: Board.default()
    field :turn, :string, default: "white"

    belongs_to :user, Chess.Store.User
    belongs_to :opponent, Chess.Store.User, references: :id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_attrs())
    |> validate_required(required_attrs())
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:opponent_id)
  end

  def change_turn("black"), do: "white"
  def change_turn("white"), do: "black"

  def for_user(user) do
    for_user_id(user.id)
  end

  def for_user_id(user_id) do
    from game in Game,
      where: game.user_id == ^user_id,
      or_where: game.opponent_id == ^user_id
  end

  def ordered(query) do
    query
    |> order_by([game], desc: game.inserted_at)
  end

  defp required_attrs, do: ~w[board turn user_id opponent_id]a
end
