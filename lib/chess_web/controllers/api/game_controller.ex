defmodule ChessWeb.Api.GameController do
  use ChessWeb, :controller

  alias Chess.Store.Game

  import Chess.Auth, only: [current_user: 1]

  def show(conn, %{"id" => id}) do
    game =
      conn
      |> current_user()
      |> Game.for_user()
      |> Repo.get!(id)

    render(conn, "show.json", game: game)
  end

  def update(conn, %{"id" => id, "move" => move_params}) do
    game =
      conn
      |> current_user()
      |> Game.for_user()
      |> Repo.get!(id)

    changeset = Game.changeset(
      game, %{board: new_board(game.board, move_params)}
    )

    case Repo.update(changeset) do
      {:ok, game} ->
        render(conn, "show.json", game: game)
    end
  end

  defp new_board(board, move_params) do
    [from_file, from_rank] = move_params["from"]
    [to_file, to_rank] = move_params["to"]

    {piece, board} = Map.pop(board, "#{from_file},#{from_rank}")

    Map.put(board, "#{to_file},#{to_rank}", piece)
  end
end
