defmodule ChessWeb.GameInfoLive do
  use Phoenix.LiveView

  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Store.Move
  alias Chess.Repo
  alias ChessWeb.Presence

  import Ecto.Query

  require Logger

  def render(assigns) do
    Phoenix.View.render(ChessWeb.GameView, "game_info.html", assigns)
  end

  def mount(_params, %{"game_id" => game_id, "user_id" => user_id}, socket) do
    topic = "game:#{game_id}"

    ChessWeb.Endpoint.subscribe(topic)

    user = Repo.get!(User, user_id)

    game =
      Game.for_user(user)
      |> preload(:user)
      |> preload(:opponent)
      |> preload(
        moves:
          ^from(
            move in Move,
            order_by: [asc: move.inserted_at]
          )
      )
      |> Repo.get!(game_id)

    Presence.track(self(), topic, :user, %{id: user_id})

    {:ok, assign(socket, game: game, user: user, presence: presence_list(topic))}
  end

  def handle_info(%{event: "move", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        socket
      ) do
    {:noreply, socket |> handle_joins(joins) |> handle_leaves(leaves)}
  end

  defp presence_list(topic) do
    Presence.list(topic)
    |> Map.get("user")
    |> Map.get(:metas)
    |> Map.new(fn meta -> {meta.id, meta} end)
  end

  defp handle_joins(socket, joins) do
    Enum.reduce(joins, socket, fn {"user", %{metas: [meta | _]}}, socket ->
      assign(socket, :presence, Map.put(socket.assigns.presence, meta.id, meta))
    end)
  end

  defp handle_leaves(socket, leaves) do
    Enum.reduce(leaves, socket, fn {"user", %{metas: [meta | _]}}, socket ->
      assign(socket, :presence, Map.delete(socket.assigns.presence, meta.id))
    end)
  end
end
