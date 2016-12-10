defmodule Chess.Api.GameController do
  use Chess.Web, :controller

  alias Chess.Game

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)
    render conn, "show.json", game: game
  end

  def update(conn, %{"id" => id, "move" => move_params}) do
    game = Repo.get!(Game, id)
    changeset = Game.changeset(game, %{ board: new_board(game, move_params) })

    case Repo.update(changeset) do
      {:ok, game} ->
        render(conn, "show.json", game: game)
    end
  end

  defp new_board(game, move_params) do
    game.board
    |> put_in(move(move_from(move_params)), nil)
    |> put_in(move(move_to(move_params)), piece(game, move_params))
  end

  defp move_from(move) do
    move["from"]
  end

  defp move(square) do
    [square["rank"], square["file"]]
  end

  defp piece(game, move) do
    get_in(game.board, move(move_from(move)))
  end

  defp move_to(move) do
    move["to"]
  end
end
