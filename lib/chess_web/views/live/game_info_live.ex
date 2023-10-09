defmodule ChessWeb.GameInfoLive do
  use Phoenix.LiveView

  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Repo

  import Ecto.Query

  def render(assigns) do
    Phoenix.View.render(ChessWeb.GameView, "game_info.html", assigns)
  end

  def mount(_params, %{"game_id" => game_id, "user_id" => user_id}, socket) do
    user = Repo.get!(User, user_id)

    game =
      Game.for_user(user)
      |> preload(:user)
      |> preload(:opponent)
      |> Repo.get!(game_id)

    {:ok, assign(socket, game: game, user: user)}
  end
end
