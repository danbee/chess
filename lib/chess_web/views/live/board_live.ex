defmodule ChessWeb.BoardLive do
  use Phoenix.LiveView

  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Repo
  alias Chess.Board

  import Chess.Auth, only: [get_user!: 1]

  def render(assigns) do
    Phoenix.View.render(ChessWeb.GameView, "board.html", assigns)
  end

  def mount(_params, %{"user_id" => user_id, "game_id" => game_id}, socket) do
    user = Repo.get!(User, user_id)

    game =
      Game.for_user(user)
      |> Repo.get!(game_id)

    {:ok, assign(socket, game: game, user: user, selected: nil, available: [])}
  end

  def handle_event("click", %{"rank" => rank, "file" => file}, socket) do
    {:noreply, socket |> handle_click(file, rank)}
  end

  defp handle_click(socket, file, rank) do
    game = socket.assigns[:game]
    board = game.board
    user = socket.assigns[:user]

    colour = ChessWeb.GameView.player_colour(user, game)

    assigns =
      case socket.assigns do
        %{:selected => nil} ->
          case Board.piece(board, {file, rank}) do
            %{"colour" => ^colour} ->
              [{:selected, selected(file, rank)}]

            _ ->
              []
          end

        _ ->
          [{:selected, nil}]
      end

    assign(socket, assigns)
  end

  defp selected(file, rank) do
    {
      String.to_integer(file),
      String.to_integer(rank)
    }
  end
end
