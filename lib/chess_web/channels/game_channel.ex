defmodule ChessWeb.GameChannel do
  @moduledoc false

  use ChessWeb, :channel

  import ChessWeb.GameView, only: [player: 2, opponent: 2]

  alias Chess.Board
  alias Chess.MoveList
  alias Chess.Moves
  alias Chess.Repo.Queries

  def join("game:" <> game_id, _params, socket) do
    send(self(), {:after_join, game_id})

    {:ok, assign(socket, :game_id, game_id)}
  end

  def handle_info({:after_join, game_id}, socket) do
    game =
      socket.assigns.current_user_id
      |> Queries.game_for_info(game_id)

    payload = %{
      player: player(game, socket.assigns.current_user_id),
      opponent: opponent(game, socket.assigns.current_user_id).name,
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

    socket.assigns.current_user_id
    |> Queries.game_with_moves(socket.assigns.game_id)
    |> Moves.make_move(move_params)
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
      |> Queries.game_with_moves(socket.assigns.game_id)

    moves = Moves.available(game.board, {
      String.to_integer(file),
      String.to_integer(rank)
    }, game.moves)

    reply = %{
      moves: Enum.map(moves, &(Tuple.to_list(&1)))
    }

    {:reply, {:ok, reply}, socket}
  end

  def convert_params(%{"from" => from, "to" => to}) do
    %{
      "from" => Enum.map(from, &(String.to_integer(&1))),
      "to" => Enum.map(to, &(String.to_integer(&1))),
    }
  end

  def send_update(socket) do
    game =
      socket.assigns.current_user_id
      |> Queries.game_with_moves(socket.assigns.game_id)

    payload = %{
      board: Board.transform(game.board),
      turn: game.turn,
      state: game.state,
      moves: MoveList.transform(game.moves),
    }

    ChessWeb.Endpoint.broadcast("game:#{game.id}", "game:update", payload)
  end
end
