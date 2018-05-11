defmodule Chess.MoveList do
  @moduledoc false

  alias Chess.Store.Move

  def transform(moves) do
    moves
    |> Enum.map(fn(move) -> Move.transform(move) end)
    |> Enum.chunk_every(2)
  end
end
