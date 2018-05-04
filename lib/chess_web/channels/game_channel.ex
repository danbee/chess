defmodule ChessWeb.GameChannel do
  @moduledoc false

  use ChessWeb, :channel

  alias Chess.Store.Game
  alias Chess.Board
  alias Chess.Moves

  def join("game:" <> game_id, _params, socket) do
    send(self(), {:after_join, game_id})

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
      turn: game.turn,
      state: game.state
    }

    socket
    |> push("game:update", payload)

    {:noreply, socket}
  end

  def handle_in("game:move", move_params, socket) do
    game =
      socket.assigns.current_user_id
      |> Game.for_user_id()
      |> Repo.get!(socket.assigns.game_id)

    changeset = Game.move_changeset(game, move_params)

    case Repo.update(changeset) do
      {:ok, game} ->
        send_update(game)

        {:noreply, socket}
      {:error, changeset} ->
        {message, _} = changeset.errors[:board]

        {:reply, {:error, %{message: message}}, socket}
    end
  end

  def handle_in(
    "game:get_available_moves",
    %{"square" => [file, rank]},
    socket
  ) do
    game =
      socket.assigns.current_user_id
      |> Game.for_user_id()
      |> Repo.get!(socket.assigns.game_id)

    moves = Moves.available(game.board, {
      String.to_integer(file),
      String.to_integer(rank)
    })

    reply = %{
      moves: Enum.map(moves, &(Tuple.to_list(&1)))
    }

    {:reply, {:ok, reply}, socket}
  end

  def send_update(game) do
    payload = %{
      board: Board.transform(game.board),
      turn: game.turn,
      state: game.state
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
