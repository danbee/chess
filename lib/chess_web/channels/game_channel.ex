defmodule ChessWeb.GameChannel do
  @moduledoc false

  use ChessWeb, :channel

  alias Ecto.Multi

  alias Chess.Store.Game
  alias Chess.Board
  alias Chess.Moves
  alias Chess.MoveList

  def join("game:" <> game_id, _params, socket) do
    send(self(), {:after_join, game_id})

    {:ok, assign(socket, :game_id, game_id)}
  end

  def handle_info({:after_join, game_id}, socket) do
    game =
      socket.assigns.current_user_id
      |> Game.for_user_id()
      |> preload(:moves)
      |> Repo.get!(game_id)

    payload = %{
      player: player(socket, game),
      board: Board.transform(game.board),
      turn: game.turn,
      state: game.state,
      moves: MoveList.transform(game.moves),
    }

    socket
    |> push("game:update", payload)

    {:noreply, socket}
  end

  def handle_in("game:move", params, socket) do
    move_params = convert_params(params)

    game =
      socket.assigns.current_user_id
      |> Game.for_user_id()
      |> preload(:moves)
      |> Repo.get!(socket.assigns.game_id)

    params = Board.move_piece(game.board, move_params)

    Multi.new
    |> Multi.update(:game, Game.move_changeset(game, params))
    |> Multi.insert(:move, Ecto.build_assoc(game, :moves, params))
    |> Repo.transaction
    |> case do
      {:ok, _} ->
        send_update(socket)

        {:noreply, socket}
      {:error, :game, changeset, _} ->
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

  def convert_params(%{"from" => from, "to" => to}) do
    %{
      "from" => Enum.map(from, fn(s) -> String.to_integer(s) end),
      "to" => Enum.map(to, fn(s) -> String.to_integer(s) end),
    }
  end

  def send_update(socket) do
    game =
      socket.assigns.current_user_id
      |> Game.for_user_id()
      |> preload(:moves)
      |> Repo.get!(socket.assigns.game_id)

    payload = %{
      board: Board.transform(game.board),
      turn: game.turn,
      state: game.state,
      moves: MoveList.transform(game.moves),
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
