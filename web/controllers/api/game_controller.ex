defmodule Chess.Api.GameController do
  use Chess.Web, :controller

  alias Chess.Game

  def show(conn, %{"id" => id}) do
    game = Repo.get!(Game, id)
    render conn, "show.json", game: game
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Repo.get!(Game, id)
    changeset = Game.changeset(game, game_params)

    case Repo.update(changeset) do
      {:ok, game} ->
        render conn, "show.json", game: game
      {:error, changeset} ->
        render(conn, "edit.html", game: game, changeset: changeset)
    end
  end
end
