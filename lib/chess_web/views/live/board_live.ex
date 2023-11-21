defmodule ChessWeb.BoardLive do
  use Phoenix.LiveView, container: {:div, class: "board__container"}

  alias Chess.Emails
  alias Chess.Mailer
  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Store.Move
  alias Chess.Repo
  alias Chess.Moves

  alias ChessWeb.GameView
  alias ChessWeb.Presence

  import Ecto.Query

  require Logger

  def render(assigns) do
    Phoenix.View.render(GameView, "board.html", assigns)
  end

  def mount(_params, %{"user_id" => user_id, "game_id" => game_id}, socket) do
    ChessWeb.Endpoint.subscribe("game:#{game_id}")

    user = Repo.get!(User, user_id)

    game =
      Game.for_user(user)
      |> Repo.get!(game_id)
      |> Repo.preload([:user, :opponent])

    {:ok, assign(socket, default_assigns(game, user))}
  end

  def handle_event("click", %{"rank" => rank, "file" => file}, socket) do
    {
      :noreply,
      socket |> handle_click(String.to_integer(file), String.to_integer(rank))
    }
  end

  defp default_assigns(game, user) do
    %{
      board: game.board,
      game: game,
      user: user,
      selected: nil,
      available: []
    }
  end

  def handle_info(%{event: "move", payload: state}, socket) do
    Logger.info("Handling move from board")
    {:noreply, assign(socket, state)}
  end

  def handle_info(%{event: "presence_diff", payload: _params}, socket) do
    {:noreply, socket}
  end

  defp handle_click(socket, file, rank) do
    game = socket.assigns.game
    board = game.board
    user = socket.assigns.user

    colour = GameView.player_colour(user, game)

    assigns =
      if colour == game.turn do
        case socket.assigns do
          %{selected: nil} ->
            handle_selection(board, colour, file, rank)

          _ ->
            handle_move(socket, file, rank)
        end
      else
        []
      end

    assign(socket, assigns)
  end

  defp handle_selection(board, colour, file, rank) do
    case GameView.piece(board, {file, rank}) do
      %{"colour" => ^colour} ->
        [
          {:selected, {file, rank}},
          {:available, Moves.available(board, {file, rank})}
        ]

      _ ->
        []
    end
  end

  defp handle_move(socket, file, rank) do
    %{game: game, available: available, selected: selected} = socket.assigns

    if {file, rank} in available do
      game
      |> Moves.make_move(%{from: selected, to: {file, rank}})
      |> case do
        {:ok, %{game: game}} ->
          game
          |> Repo.reload()
          |> Repo.preload([:user, :opponent])
          |> Repo.preload(
            moves:
              from(
                move in Move,
                order_by: [asc: move.inserted_at]
              )
          )
          |> broadcast_move(game.board)

          email_move(socket, game)

          [
            {:selected, nil},
            {:available, []},
            {:board, game.board},
            {:game, game}
          ]

        {:error, _, _, _} ->
          []
      end
    else
      [{:selected, nil}, {:available, []}]
    end
  end

  defp email_move(socket, game) do
    opponent_id =
      GameView.opponent_id(game, socket.assigns.user.id)
      |> Integer.to_string()

    "game:#{game.id}"
    |> Presence.list()
    |> case do
      %{^opponent_id => _} ->
        nil

      _ ->
        socket
        |> Emails.opponent_moved_email(game)
        |> Mailer.deliver_later()
    end
  end

  defp broadcast_move(game, board) do
    ChessWeb.Endpoint.broadcast_from(
      self(),
      "game:#{game.id}",
      "move",
      %{game: game, board: board}
    )
  end
end
