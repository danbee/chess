defmodule ChessWeb.GameChannel do
  @moduledoc false

  use Phoenix.Channel

  alias Chess.Board

  def join("game:" <> _game_id, _params, socket) do
    {:ok, socket}
  end

  def update_game(game) do
    payload = %{
      board: Board.transform(game.board),
      turn: game.turn
    }
    ChessWeb.Endpoint.broadcast("game:#{game.id}", "game_update", payload)
  end
end
