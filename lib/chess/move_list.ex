defmodule Chess.MoveList do
  @moduledoc false

  alias Chess.Store.Move

  def transform(moves) do
    moves
    |> Enum.map(&(Move.transform(&1)))
    |> Enum.chunk_every(2)
  end
end
