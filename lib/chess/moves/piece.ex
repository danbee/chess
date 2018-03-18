defmodule Chess.Moves.Piece do
  @moduledoc false

  alias Chess.Board
  alias Chess.Moves.Generator
  alias Chess.Moves.Pieces.Knight

  def find(board, piece) do
  end

  def attacked?(board, {file, rank}) do
    attacked_by_rook_or_queen?(board, {file, rank}) ||
      attacked_by_bishop_or_queen?(board, {file, rank}) ||
      attacked_by_knight?(board, {file, rank})
  end

  defp attacked_by_rook_or_queen?(board, {file, rank}) do
    _attacked?(board, {file, rank}, {0, 1}, ["rook", "queen"]) ||
      _attacked?(board, {file, rank}, {0, -1}, ["rook", "queen"]) ||
      _attacked?(board, {file, rank}, {1, 0}, ["rook", "queen"]) ||
      _attacked?(board, {file, rank}, {-1, 0}, ["rook", "queen"])
  end

  defp attacked_by_bishop_or_queen?(board, {file, rank}) do
    _attacked?(board, {file, rank}, {1, 1}, ["bishop", "queen"]) ||
      _attacked?(board, {file, rank}, {1, -1}, ["bishop", "queen"]) ||
      _attacked?(board, {file, rank}, {-1, 1}, ["bishop", "queen"]) ||
      _attacked?(board, {file, rank}, {-1, -1}, ["bishop", "queen"])
  end

  defp attacked_by_knight?(board, {file, rank}) do
    _attacked?(board, {file, rank}, Knight.pattern, "knight")
  end

  defp _attacked?(board, {file, rank}, {fv, rv}, pieces) do
    {file, rank} =
      board
      |> Generator.moves({file, rank}, {fv, rv})
      |> List.last

    piece = board["#{file},#{rank}"]

    Enum.any?(pieces, &(match?(%{"type" => &1}, piece)))
  end

  defp _attacked?(board, {file, rank}, pattern, piece_type) do
    moves =
      board
      |> Generator.moves({file, rank}, pattern)

    Enum.any?(moves, &(match_piece(board, &1, piece_type)))
  end

  defp match_piece(board, {file, rank}, piece_type) do
    piece =
      board
      |> Board.piece({file, rank})

    piece["type"] == piece_type
  end
end
