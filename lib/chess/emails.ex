defmodule Chess.Emails do
  @moduledoc false

  import Bamboo.Email

  def new_game_email(conn, game) do
    new_email()
    |> to(game.opponent)
    |> from("games@64squares.club")
    |> subject("New chess game created!")
    |> text_body("""
      #{game.user.name} has invited you to play a game of chess.

      #{ChessWeb.Router.Helpers.game_url(conn, :show, game)}
    """)
  end
end
