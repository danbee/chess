defmodule ChessWeb.GameChannel do
  @moduledoc false

  use ChessWeb, :channel

  import ChessWeb.GameView, only: [opponent: 2]
  import ChessWeb.GameChannelView,
    only: [after_join_payload: 2, update_payload: 1]

  alias Chess.Emails
  alias Chess.Mailer
  alias Chess.Moves
  alias Chess.Repo.Queries
  alias ChessWeb.Presence

  def join("game:" <> game_id, _params, socket) do
    send(self(), {:after_join, game_id})

    {:ok, assign(socket, :game_id, game_id)}
  end

  def handle_info({:after_join, game_id}, socket) do
    game =
      socket.assigns.user_id
      |> Queries.game_for_info(game_id)

    socket
    |> push("game:update", after_join_payload(socket, game))

    track_presence(socket)

    {:noreply, socket}
  end

  def handle_in("game:move", params, socket) do
    game =
      socket.assigns.user_id
      |> Queries.game_for_info(socket.assigns.game_id)

    move_params = convert_params(params)

    game
    |> Moves.make_move(move_params)
    |> case do
      {:ok, _} ->
        update_opponent(socket, game)

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
      socket.assigns.user_id
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

  def update_opponent(socket, game) do
    opponent_id =
      opponent(game, socket.assigns.user_id).id
      |> Integer.to_string

    send_update(socket)

    "game:#{game.id}"
    |> Presence.list
    |> case do
      %{^opponent_id => _} ->
        nil
      _ ->
        socket
        |> Emails.opponent_moved_email(game)
        |> Mailer.deliver_later
    end
  end

  def track_presence(socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      user_id: socket.assigns.user_id,
      online_at: inspect(System.system_time(:seconds))
    })

    socket
    |> push("presence_state", Presence.list(socket))
  end

  def convert_params(%{"from" => from, "to" => to}) do
    %{
      "from" => Enum.map(from, &(String.to_integer(&1))),
      "to" => Enum.map(to, &(String.to_integer(&1))),
    }
  end

  def send_update(socket) do
    game =
      socket.assigns.user_id
      |> Queries.game_with_moves(socket.assigns.game_id)

    ChessWeb.Endpoint.broadcast("game:#{game.id}", "game:update", update_payload(game))
  end
end
