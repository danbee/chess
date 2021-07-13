defmodule ChessWeb.BoardLive do
  use Phoenix.LiveView

  alias Chess.Store.User
  alias Chess.Store.Game
  alias Chess.Repo
  alias Chess.Board
  alias Chess.Moves

  import Chess.Auth, only: [get_user!: 1]

  def render(assigns) do
    Phoenix.View.render(ChessWeb.GameView, "board.html", assigns)
  end

  def mount(_params, %{"user_id" => user_id, "game_id" => game_id}, socket) do
    user = Repo.get!(User, user_id)

    game =
      Game.for_user(user)
      |> Repo.get!(game_id)

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
      board: Board.transform(game.board),
      game: game,
      user: user,
      selected: nil,
      available: []
    }
  end

  defp handle_click(socket, file, rank) do
    game = socket.assigns[:game]
    board = game.board
    user = socket.assigns[:user]

    colour = ChessWeb.GameView.player_colour(user, game)

    assigns =
      if colour == game.turn do
        case socket.assigns do
          %{selected: nil} ->
            handle_selection(board, colour, file, rank)

          _ ->
            handle_move(socket.assigns, file, rank)
        end
      end

    assign(socket, assigns)
  end

  defp handle_selection(board, colour, file, rank) do
    case Board.piece(board, {file, rank}) do
      %{"colour" => ^colour} ->
        [
          {:selected, {file, rank}},
          {:available, Moves.available(board, {file, rank})}
        ]

      _ ->
        []
    end
  end

  defp handle_move(
         %{game: game, available: available, selected: selected},
         file,
         rank
       ) do
    if {file, rank} in available do
      new_game =
        game
        |> Moves.make_move(%{from: selected, to: {file, rank}})
        |> case do
          {:ok, %{game: new_game}} ->
            new_game
        end

      new_board = Board.transform(new_game.board)

      [
        {:selected, nil},
        {:available, []},
        {:board, new_board},
        {:game, new_game}
      ]
    else
      [{:selected, nil}, {:available, []}]
    end
  end
end
