defmodule ChessWeb.GameView do
  use ChessWeb, :view

  alias Chess.Store.Game

  import Chess.Auth, only: [current_user: 1]

  def won_lost(conn, game) do
    if game_over?(game) && game.state == "checkmate" do
      your_turn?(conn, game) && "You lost" || "You won"
    end
  end

  def game_over?(game) do
    Game.game_over?(game)
  end

  def state(conn, game) do
    cond do
      Game.game_over?(game) ->
        states[game.state]
      your_turn?(conn, game) ->
        "Your turn"
      true -> nil
    end
  end

  def turn_class(conn, game) do
    if your_turn?(conn, game) && !Game.game_over?(game) do
      "your-turn"
    end
  end

  def your_turn?(conn, game) do
    player_colour(conn, game) == game.turn
  end

  def player_colour(conn, game) do
    current_user(conn).id == game.user_id && "white" || "black"
  end

  def opponent(conn, game) do
    if current_user(conn).id == game.user_id do
      game.opponent
    else
      game.user
    end
  end

  defp states do
    %{
      "checkmate" => "Checkmate!",
      "stalemate" => "Stalemate",
      "check" => "Check",
    }
  end
end
