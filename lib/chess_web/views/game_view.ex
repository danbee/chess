defmodule ChessWeb.GameView do
  use ChessWeb, :view

  import Chess.Auth, only: [current_user: 1]

  def turn_class(conn, game) do
    if your_turn?(conn, game) do
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
end
