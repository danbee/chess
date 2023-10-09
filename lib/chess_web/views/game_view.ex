defmodule ChessWeb.GameView do
  use ChessWeb, :view

  alias Chess.GameState

  import Phoenix.Component
  import Chess.Auth, only: [current_user: 1]

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
        states(game.state)

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

  def your_turn?(user, game) do
    user
    |> player_colour(game) == game.turn
  end

  def player_colour(user, game) do
    (user.id == game.user_id && "white") || "black"
  end

  def piece(board, {file, rank}) do
    board["#{file},#{rank}"]
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

  def opponent(game, user_id) do
    if game.user_id == user_id do
      game.opponent
    else
      game.user
    end
  end

  def states(state) do
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
