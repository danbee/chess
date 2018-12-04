defmodule Chess.Repo.Queries do
  @moduledoc false

  import Ecto.Query

  alias Chess.Repo
  alias Chess.Store.Game
  alias Chess.Store.User
  alias Chess.Store.Move

  def games_for_index(user) do
    Game
    |> Game.for_user(user)
    |> preload([:user, :opponent])
    |> Repo.all
  end

  def game_for_show(user, game_id) do
    Game
    |> Game.for_user(user)
    |> preload([:user, :opponent])
    |> Repo.get!(game_id)
  end

  def game_for_info(user_id, game_id) do
    Game
    |> Game.for_user_id(user_id)
    |> preload([:moves, :user, :opponent])
    |> Repo.get!(game_id)
  end

  def game_with_moves(user_id, game_id) do
    Game
    |> Game.for_user_id(user_id)
    |> preload(:moves)
    |> Repo.get!(game_id)
  end

  def moves_with_captures(game_id) do
    Move
    |> Move.for_game_id(game_id)
    |> Move.with_captures
    |> Repo.all
  end

  def opponents(user, query_string) do
    User
    |> User.opponents(user)
    |> User.matches(query_string)
  end
end
