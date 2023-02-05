defmodule Chess.GameState do
  @moduledoc false

  alias Chess.Board
  alias Chess.Moves
  alias Chess.Moves.Piece

  def game_over?(game) do
    game.state == "checkmate" ||
      game.state == "stalemate"
  end

  def state(board, colour) do
    cond do
      player_checkmated?(board, colour) ->
        "checkmate"

      player_stalemated?(board, colour) ->
        "stalemate"

      king_in_check?(board, colour) ->
        "check"

      true ->
        nil
    end
  end

  def player_checkmated?(board, colour) do
    king_in_check?(board, colour) &&
      player_cannot_move?(board, colour)
  end

  def player_stalemated?(board, colour) do
    !king_in_check?(board, colour) &&
      player_cannot_move?(board, colour)
  end

  def king_in_check?(board, colour) do
    king =
      board
      |> Board.search(%{"type" => "king", "colour" => colour})
      |> List.first()

    if is_nil(king) do
      raise "There is no #{colour} king!"
    end

    board
    |> Piece.attacked?(king)
  end

  def player_cannot_move?(board, colour) do
    board
    |> Board.search(%{"colour" => colour})
    |> Enum.all?(fn {file, rank} ->
      board
      |> piece_cannot_move?({file, rank})
    end)
  end

  def piece_cannot_move?(board, {file, rank}) do
    piece =
      board
      |> Board.piece({file, rank})

    board
    |> Moves.available({file, rank})
    |> Enum.all?(fn {to_file, to_rank} ->
      board
      |> Board.move_piece(%{"from" => [file, rank], "to" => [to_file, to_rank]})
      |> Map.get(:board)
      |> king_in_check?(piece["colour"])
    end)
  end
end
