defmodule Chess.Emails do
  @moduledoc false

  import Bamboo.Email

  def new_game_email(conn, game) do
    new_email()
    |> to(game.opponent)
    |> from({"64squares", "games@64squares.club"})
    |> subject(
      "[64squares] #{game.user.name} has invited you to play a game of chess."
    )
    |> text_body("""
      Game link: #{ChessWeb.Router.Helpers.game_url(conn, :show, game)}
    """)
  end
end
