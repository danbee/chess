defmodule Chess.Repo.Queries do
  @moduledoc false

  import Ecto.Query

  alias Chess.Repo
  alias Chess.Store.Game
  alias Chess.Store.User

  def game_for_info(user_id, game_id) do
    user_id
    |> Game.for_user_id()
    |> preload([:moves, :user, :opponent])
    |> Repo.get!(game_id)
  end

  def game_with_moves(user_id, game_id) do
    user_id
    |> Game.for_user_id()
    |> preload(:moves)
    |> Repo.get!(game_id)
  end

  def opponents(user, query_string) do
    user
    |> User.opponents
    |> User.matches(query_string)
  end
end
