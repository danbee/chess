defmodule ChessWeb.GameView do
  use ChessWeb, :view

  alias Chess.GameState
  alias Chess.Repo

  import Phoenix.Component
  import Chess.Auth, only: [current_user: 1]

  @pieces %{
    pawn: "",
    knight: "N",
    bishop: "B",
    rook: "R",
    queen: "Q",
    king: "K"
  }

  def won_lost(user, game) do
    if game_over?(game) && game.state == "checkmate" do
      (your_turn?(user, game) &&
         gettext("You lost")) ||
        gettext("You won")
    end
  end

  def game_over?(game) do
    GameState.game_over?(game)
  end

  def state(user, game) do
    cond do
      GameState.game_over?(game) ->
        state_text(game.state)

      your_turn?(user, game) ->
        gettext("Your turn")

      true ->
        nil
    end
  end

  def turn_class(user, game) do
    if your_turn?(user, game) && !GameState.game_over?(game) do
      "games-list__your-turn"
    end
  end

  def white?(user, game) do
    player_colour(user, game) == "white"
  end

  def black?(user, game) do
    player_colour(user, game) == "black"
  end

  def your_turn?(user, game) do
    user
    |> player_colour(game) == game.turn
  end

  def player_colour(user, game) do
    (user.id == game.user_id && "white") || "black"
  end

  def piece(board, {file, rank}) do
    Chess.Board.piece(board, {file, rank})
  end

  def files(user, game) do
    ranks(user, game)
    |> Enum.reverse()
  end

  def ranks(user, game) do
    if game.user_id == user.id do
      7..0
    else
      0..7
    end
  end

  def player(game, user_id) do
    if game.user_id == user_id do
      "white"
    else
      "black"
    end
  end

  def opponent_id(game, user_id) do
    if game.user_id == user_id do
      game.opponent_id
    else
      game.user_id
    end
  end

  def opponent(game, user_id) do
    if game.user_id == user_id do
      game.opponent
    else
      game.user
    end
  end

  def move_text(move) do
    move = Chess.Store.Move.transform(move)

    piece_type = move.piece["type"] |> String.to_atom()

    [
      @pieces[piece_type],
      move.to
    ]
    |> Enum.join()
  end

  def state_text(state) do
    Map.get(
      %{
        "checkmate" => gettext("Checkmate!"),
        "stalemate" => gettext("Stalemate"),
        "check" => gettext("Check")
      },
      state
    )
  end
end
