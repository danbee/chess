defmodule ChessWeb.GameView do
  use ChessWeb, :view

  import Chess.Auth, only: [current_user: 1]

  def opponent(conn, game) do
    if current_user(conn).id == game.user_id do
      game.opponent
    else
      game.user
    end
  end
end
