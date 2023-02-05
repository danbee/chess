defmodule ChessWeb.GameView do
  use ChessWeb, :view

  alias Chess.GameState

  import Chess.Auth, only: [current_user: 1]

  def won_lost(conn, game) do
    if game_over?(game) && game.state == "checkmate" do
      (your_turn?(conn, game) &&
         gettext("You lost")) ||
        gettext("You won")
    end
  end

  def game_over?(game) do
    GameState.game_over?(game)
  end

  def state(conn, game) do
    cond do
      GameState.game_over?(game) ->
        states()[game.state]

      your_turn?(conn, game) ->
        gettext("Your turn")

      true ->
        nil
    end
  end

  def turn_class(conn, game) do
    if your_turn?(conn, game) && !GameState.game_over?(game) do
      "games-list__your-turn"
    end
  end

  def your_turn?(conn, game) do
    player_colour(conn, game) == game.turn
  end

  def player_colour(conn, game) do
    (current_user(conn).id == game.user_id && "white") || "black"
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

  defp states do
    %{
      "checkmate" => gettext("Checkmate!"),
      "stalemate" => gettext("Stalemate"),
      "check" => gettext("Check")
    }
  end
end
