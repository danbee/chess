defmodule Chess.GameState do
  @moduledoc false

  alias Chess.Board
  alias Chess.Moves
  alias Chess.Moves.Piece

  def player_checkmated?(board, colour) do
    board
    |> Board.search(%{"colour" => colour})
    |> Enum.all?(fn({file, rank}) ->
      board
      |> cannot_escape_check?({file, rank})
    end)
  end

  def cannot_escape_check?(board, {file, rank}) do
    piece =
      board
      |> Board.piece({file, rank})

    board
    |> Moves.available({file, rank})
    |> Enum.all?(fn({to_file, to_rank}) ->
      board
      |> Board.move_piece(%{"from" => [file, rank], "to" => [to_file, to_rank]})
      |> king_in_check?(piece["colour"])
    end)
  end

  def king_in_check?(board, colour) do
    king =
      board
      |> Board.search(%{"type" => "king", "colour" => colour})
      |> List.first

    board
    |> Piece.attacked?(king)
  end
end
