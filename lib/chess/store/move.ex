defmodule Chess.Store.Move do
  @moduledoc false

  use Ecto.Schema
  use Timex.Ecto.Timestamps

  import Ecto.Changeset
  # import Ecto.Query

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
    |> cast(params, required_attrs())
    |> validate_required(required_attrs())
  end

  def translate(move) do
    [
      <<97 + move.from["file"], 49 + move.from["rank"]>>,
      <<97 + move.to["file"], 49 + move.to["rank"]>>
    ]
    |> Enum.join("-")
  end

  defp required_attrs, do: ~w[game_id from to piece]a
end
