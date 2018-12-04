defmodule Chess.Moves do
  @moduledoc false

  alias Ecto.Multi

  alias Chess.Repo
  alias Chess.Board
  alias Chess.Store.Game
  alias Chess.Store.Move

  alias Chess.Moves.Pieces.Pawn
  alias Chess.Moves.Pieces.Bishop
  alias Chess.Moves.Pieces.Knight
  alias Chess.Moves.Pieces.Rook
  alias Chess.Moves.Pieces.Queen
  alias Chess.Moves.Pieces.King

  def make_move(game, move_params) do
    params =
      game.board
      |> Board.move_piece(move_params)

    Multi.new
    |> Multi.update(:game, Game.move_changeset(game, params))
    |> Multi.insert(:move, Move.changeset(%Move{game_id: game.id}, params))
    |> Repo.transaction
  end

  def available(board, {file, rank}, move_list \\ []) do
    piece =
      board
      |> Board.piece({file, rank})

    case piece do
      %{"type" => "pawn"} ->
        Pawn.moves(board, {file, rank})
      %{"type" => "rook"} ->
        Rook.moves(board, {file, rank})
      %{"type" => "bishop"} ->
        Bishop.moves(board, {file, rank})
      %{"type" => "knight"} ->
        Knight.moves(board, {file, rank})
      %{"type" => "king"} ->
        King.moves(board, {file, rank}, move_list)
      %{"type" => "queen"} ->
        Queen.moves(board, {file, rank})
    end
  end
end
