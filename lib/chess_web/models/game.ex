defmodule Chess.Game do
  use Chess.Web, :model

  schema "games" do
    field :board, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct) do
    struct
    |> cast(%{}, [:board])
    |> set_default_board
    |> validate_required([:board])
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:board])
    |> validate_required([:board])
  end

  def ordered(query) do
    query
    |> order_by([game], desc: game.inserted_at)
  end

  def set_default_board(changeset) do
    changeset
    |> put_change(:board, Chess.Board.default)
  end
end
