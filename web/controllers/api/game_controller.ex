defmodule Chess.Api.GameController do
  use Chess.Web, :controller

  alias Chess.Game

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)
    render conn, "show.json", game: game
  end

  def update(conn, %{"id" => id, "move" => move_params}) do
    game = Repo.get!(Game, id)
    changeset = Game.changeset(game, %{board: new_board(game.board, move_params)})

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
