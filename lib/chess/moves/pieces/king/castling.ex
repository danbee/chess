defmodule Chess.Moves.Pieces.King.Castling do
  @moduledoc false

  alias Chess.Board
  alias Chess.GameState
  alias Chess.Store.Move

  def moves(board, {4, rank}, move_list) when rank == 0 or rank == 7 do
    colour =
      board
      |> Board.piece({4, rank})
      |> Map.get("colour")

    if not king_has_moved?(move_list, colour) do
      board
      |> _moves(rank, colour, move_list)
    else
      []
    end
  end

  def moves(_board, _piece, _move_list), do: []

  def _moves(board, _rank, colour, move_list) do
    board
    |> Board.search(%{"type" => "rook", "colour" => colour})
    |> Enum.map(fn {file, rank} ->
      case file do
        0 -> queen_side_move(board, rank, colour, move_list)
        7 -> king_side_move(board, rank, colour, move_list)
        _ -> nil
      end
    end)
    |> Enum.reject(&is_nil(&1))
  end

  defp king_has_moved?(move_list, colour) do
    move_list
    |> Enum.any?(fn move ->
      match?(
        %Move{
          piece: %{"type" => "king", "colour" => ^colour}
        },
        move
      )
    end)
  end

  defp queen_side_move(board, rank, colour, move_list) do
    if queen_side_squares_empty?(board, rank) &&
         !queen_side_in_check?(board, rank, colour) &&
         !rook_has_moved?(0, move_list, colour) do
      {2, rank}
    end
  end

  defp king_side_move(board, rank, colour, move_list) do
    if king_side_squares_empty?(board, rank) &&
         !king_side_in_check?(board, rank, colour) &&
         !rook_has_moved?(7, move_list, colour) do
      {6, rank}
    end
  end

  defp rook_has_moved?(file, move_list, colour) do
    move_list
    |> Enum.any?(fn move ->
      match?(
        %Move{
          piece: %{"type" => "rook", "colour" => ^colour},
          from: %{"file" => ^file}
        },
        move
      )
    end)
  end

  defp queen_side_in_check?(board, rank, colour) do
    [{2, rank}, {3, rank}]
    |> Enum.any?(fn {to_file, to_rank} ->
      board
      |> Board.move_piece(%{from: {4, rank}, to: {to_file, to_rank}})
      |> Map.get(:board)
      |> GameState.king_in_check?(colour)
    end)
  end

  defp king_side_in_check?(board, rank, colour) do
    [{5, rank}, {6, rank}]
    |> Enum.any?(fn {to_file, to_rank} ->
      board
      |> Board.move_piece(%{from: {4, rank}, to: {to_file, to_rank}})
      |> Map.get(:board)
      |> GameState.king_in_check?(colour)
    end)
  end

  defp queen_side_squares_empty?(board, rank) do
    [{1, rank}, {2, rank}, {3, rank}]
    |> Enum.map(&Board.piece(board, &1))
    |> Enum.all?(&is_nil(&1))
  end

  defp king_side_squares_empty?(board, rank) do
    [{5, rank}, {6, rank}]
    |> Enum.map(&Board.piece(board, &1))
    |> Enum.all?(&is_nil(&1))
  end
end
