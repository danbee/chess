defmodule ChessWeb.GameInfoLive do
  use Phoenix.LiveView

  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Store.Move
  alias Chess.Repo

  import Ecto.Query

  require Logger

  def render(assigns) do
    Phoenix.View.render(ChessWeb.GameView, "game_info.html", assigns)
  end

  def mount(_params, %{"game_id" => game_id, "user_id" => user_id}, socket) do
    ChessWeb.Endpoint.subscribe("game:#{game_id}")

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

    {:ok, assign(socket, game: game, user: user)}
  end

  def handle_info(%{event: "move", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end
end
