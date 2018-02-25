defmodule ChessWeb.Api.GameController do
  use ChessWeb, :controller

  alias Chess.Store.Game
  alias Chess.Board

  alias ChessWeb.GameChannel

  import Chess.Auth, only: [current_user: 1]

  def show(conn, %{"id" => id}) do
    game =
      conn
      |> current_user()
      |> Game.for_user()
      |> Repo.get!(id)

    conn
    |> json(game_attrs(conn, game))
  end

  def update(conn, %{"id" => id, "move" => move_params}) do
    game =
      conn
      |> current_user()
      |> Game.for_user()
      |> Repo.get!(id)

    changeset = Game.changeset(
      game, %{
        board: Board.move_piece(game.board, move_params),
        turn: Game.change_turn(game.turn)
      }
    )

    case Repo.update(changeset) do
      {:ok, game} ->
        GameChannel.update_game(game)

        conn
        |> json(game_attrs(conn, game))
    end
  end

  defp game_attrs(conn, game) do
    %{
      board: Board.transform(game.board),
      player: player(conn, game),
      turn: game.turn
    }
  end

  defp player(conn, game) do
    if game.user_id == current_user(conn).id do
      "white"
    else
      "black"
    end
  end
end
