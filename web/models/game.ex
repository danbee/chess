defmodule Chess.Game do
  use Chess.Web, :model

  schema "games" do
    field :board, :map

    timestamps
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
    |> order_by([game], game.id)
  end

  def set_default_board(changeset) do
    changeset
    |> put_change(:board, default_board)
  end

  def default_board do
    %{
      "8" => %{
        a: %{ type: "rook",   colour: "black" },
        b: %{ type: "knight", colour: "black" },
        c: %{ type: "bishop", colour: "black" },
        d: %{ type: "queen",  colour: "black" },
        e: %{ type: "king",   colour: "black" },
        f: %{ type: "bishop", colour: "black" },
        g: %{ type: "knight", colour: "black" },
        h: %{ type: "rook",   colour: "black" }
      },
      "7" => %{
        a: %{ type: "pawn", colour: "black" },
        b: %{ type: "pawn", colour: "black" },
        c: %{ type: "pawn", colour: "black" },
        d: %{ type: "pawn", colour: "black" },
        e: %{ type: "pawn", colour: "black" },
        f: %{ type: "pawn", colour: "black" },
        g: %{ type: "pawn", colour: "black" },
        h: %{ type: "pawn", colour: "black" }
      },
      "6" => %{ a: nil, b: nil, c: nil, d: nil, e: nil, f: nil, g: nil, h: nil },
      "5" => %{ a: nil, b: nil, c: nil, d: nil, e: nil, f: nil, g: nil, h: nil },
      "4" => %{ a: nil, b: nil, c: nil, d: nil, e: nil, f: nil, g: nil, h: nil },
      "3" => %{ a: nil, b: nil, c: nil, d: nil, e: nil, f: nil, g: nil, h: nil },
      "2" => %{
        a: %{ type: "pawn", colour: "white" },
        b: %{ type: "pawn", colour: "white" },
        c: %{ type: "pawn", colour: "white" },
        d: %{ type: "pawn", colour: "white" },
        e: %{ type: "pawn", colour: "white" },
        f: %{ type: "pawn", colour: "white" },
        g: %{ type: "pawn", colour: "white" },
        h: %{ type: "pawn", colour: "white" }
      },
      "1" => %{
        a: %{ type: "rook",   colour: "white" },
        b: %{ type: "knight", colour: "white" },
        c: %{ type: "bishop", colour: "white" },
        d: %{ type: "queen",  colour: "white" },
        e: %{ type: "king",   colour: "white" },
        f: %{ type: "bishop", colour: "white" },
        g: %{ type: "knight", colour: "white" },
        h: %{ type: "rook",   colour: "white" }
      }
    }
  end
end
