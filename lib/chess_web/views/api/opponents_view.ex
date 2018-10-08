defmodule ChessWeb.Api.OpponentsView do
  use ChessWeb, :view

  def render("index.json", %{opponents: opponents}) do
    %{
      opponents: Enum.map(opponents, fn opponent ->
        opponent_attrs(opponent)
      end)
    }
  end

  def opponent_attrs(opponent) do
    %{
      id: opponent.id,
      name: opponent.name,
    }
  end
end
