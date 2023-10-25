defmodule ChessWeb.OpponentFinderLive do
  use Phoenix.LiveView

  alias Chess.Store.User
  alias Chess.Repo
  alias Chess.Repo.Queries

  alias ChessWeb.GameView

  def render(assigns) do
    Phoenix.View.render(GameView, "opponent_finder.html", assigns)
  end

  def mount(_params, %{"user_id" => user_id}, socket) do
    ChessWeb.Endpoint.subscribe("opponent_finder:#{user_id}")

    user = Repo.get!(User, user_id)

    {:ok, assign(socket, default_assigns(user))}
  end

  def handle_event("search", %{"q" => q}, socket) do
    opponents =
      case q do
        "" ->
          []

        query_string ->
          socket.assigns.user
          |> Queries.opponents(query_string)
          |> Repo.all()
      end

    {:noreply, assign(socket, %{opponents: opponents})}
  end

  def handle_event("select", %{"id" => id}, socket) do
    opponent = Repo.get!(User, id)

    {:noreply, assign(socket, %{q: "", opponents: [], selected: opponent})}
  end

  def default_assigns(user) do
    %{
      q: "",
      user: user,
      opponents: [],
      selected: %{}
    }
  end
end
