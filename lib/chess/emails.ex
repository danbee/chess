defmodule Chess.Emails do
  @moduledoc false

  import Bamboo.Email
  import ChessWeb.GameView, only: [opponent: 2]

  alias Chess.Repo
  alias Chess.Store.User
  alias ChessWeb.Router.Helpers

  def new_game_email(conn, game) do
    new_email()
    |> to(game.opponent)
    |> from({"64squares", "games@64squares.club"})
    |> subject(
      "[64squares] #{game.user.name} has invited you to play a game of chess."
    )
    |> text_body("""
      Game link: #{Helpers.game_url(conn, :show, game)}
    """)
  end

  def opponent_moved_email(socket, game) do
    user = Repo.get(User, socket.assigns.user_id)
    opponent = opponent(game, socket.assigns.user_id)

    new_email()
    |> to(opponent)
    |> from({"64squares", "games@64squares.club"})
    |> subject(
      "[64squares] #{user.name} has moved."
    )
    |> text_body("""
      Game link: #{Helpers.game_url(socket, :show, game)}
    """)
  end
end
