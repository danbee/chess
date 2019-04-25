defmodule ChessWeb.GameChannelView do
  @moduledoc false

  use ChessWeb, :view

  import ChessWeb.GameView, only: [player: 2, opponent: 2]

  alias Chess.Board
  alias Chess.MoveList
  alias Chess.Repo.Queries

  def after_join_payload(socket, game) do
    %{
      player_id: socket.assigns.user_id,
      opponent_id: opponent(game, socket.assigns.user_id).id,
      player: player(game, socket.assigns.user_id),
      opponent: opponent(game, socket.assigns.user_id).name,
      board: Board.transform(game.board),
      turn: game.turn,
      state: game.state,
      moves: MoveList.transform(game.moves),
      graveyard: %{
        white: Queries.captures_for_colour(game, "white"),
        black: Queries.captures_for_colour(game, "black"),
      },
    }
  end

  def update_payload(game) do
    %{
      board: Board.transform(game.board),
      turn: game.turn,
      state: game.state,
      moves: MoveList.transform(game.moves),
      graveyard: %{
        white: Queries.captures_for_colour(game, "white"),
        black: Queries.captures_for_colour(game, "black"),
      },
    }
  end
end
