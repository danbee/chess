defmodule Chess.Store.Move do
  @moduledoc false

  use Ecto.Schema
  use Timex.Ecto.Timestamps

  import Ecto.Changeset
  import Ecto.Query

  alias Chess.Store.Game

  schema "moves" do
    field :from, :map
    field :to, :map

    field :piece, :map
    field :piece_captured, :map

    belongs_to :game, Game

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, permitted_attrs())
    |> validate_required(required_attrs())
  end

  def for_game_id(query, game_id) do
    from move in query,
      where: move.game_id == ^game_id
  end

  def with_captures(query) do
    from move in query,
      where: not is_nil(move.piece_captured)
  end

  def transform(move) do
    %{
      id: move.id,
      piece: move.piece,
      from: <<97 + move.from["file"], 49 + move.from["rank"]>>,
      to: <<97 + move.to["file"], 49 + move.to["rank"]>>,
    }
  end

  defp permitted_attrs, do: ~w[game_id from to piece piece_captured]a

  defp required_attrs, do: ~w[game_id from to piece]a
end
