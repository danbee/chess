defmodule ChessWeb.GameChannel do
  @moduledoc false

  use ChessWeb, :channel

  alias Chess.Store.Game
  alias Chess.Board

  import Chess.Auth, only: [current_user: 1]

  def join("game:" <> game_id, _params, socket) do
    send(self, {:after_join, game_id})

    {:ok, assign(socket, :game_id, game_id)}
  end

  def handle_info({:after_join, game_id}, socket) do
    game =
      socket.assigns.current_user_id
      |> Game.for_user_id()
      |> Repo.get!(game_id)

    payload = %{
      player: player(socket, game),
      board: Board.transform(game.board),
      turn: game.turn
    }
    push(socket, "game:update", payload)

    {:noreply, socket}
  end

  def handle_in("game:move", move_params, socket) do
    game =
      socket.assigns.current_user_id
      |> Game.for_user_id()
      |> Repo.get!(socket.assigns.game_id)

    changeset = Game.changeset(
      game, %{
        board: Board.move_piece(game.board, move_params),
        turn: Game.change_turn(game.turn)
      }
    )

    case Repo.update(changeset) do
      {:ok, game} ->
        send_update(game)

        {:noreply, socket}
    end
  end

  def send_update(game) do
    payload = %{
      board: Board.transform(game.board),
      turn: game.turn
    }
    ChessWeb.Endpoint.broadcast("game:#{game.id}", "game:update", payload)
  end

  defp player(socket, game) do
    if game.user_id == socket.assigns.current_user_id do
      "white"
    else
      "black"
    end
  end
end
