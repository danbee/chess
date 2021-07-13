defmodule Chess.Board do
  @moduledoc false

  def transform(board) do
    Enum.map(0..7, fn rank ->
      Enum.map(0..7, fn file ->
        board
        |> piece({file, rank})
      end)
    end)
  end

  def search(board, %{"type" => type, "colour" => colour}) do
    board
    |> Enum.filter(fn {_index, piece} ->
      match?(%{"type" => ^type, "colour" => ^colour}, piece)
    end)
    |> indexes_to_tuples
  end

  def search(board, %{"colour" => colour}) do
    board
    |> Enum.filter(fn {_index, piece} ->
      match?(%{"colour" => ^colour}, piece)
    end)
    |> indexes_to_tuples
  end

  def piece(board, {file, rank}) do
    board["#{file},#{rank}"]
  end

  def move_piece(board, %{
        "from" => [from_file, from_rank],
        "to" => [to_file, to_rank]
      }) do
    {piece, board} = Map.pop(board, to_index({from_file, from_rank}))
    {piece_captured, board} = Map.pop(board, to_index({to_file, to_rank}))
    board = Map.put(board, to_index({to_file, to_rank}), piece)

    board =
      if castling_move?(piece, from_file, to_file) do
        board
        |> castling_move(%{
          from: {from_file, from_rank},
          to: {to_file, to_rank}
        })
        |> Map.get(:board)
      else
        board
      end

    %{
      from: %{"file" => from_file, "rank" => from_rank},
      to: %{"file" => to_file, "rank" => to_rank},
      board: board,
      piece: piece,
      piece_captured: piece_captured
    }
  end

  def castling_move?(%{"type" => "king"}, 4, to_file) do
    to_file == 2 || to_file == 6
  end

  def castling_move?(_, _, _), do: false

  def castling_move(board, %{from: {4, rank}, to: {2, _rank}}) do
    move_piece(board, %{
      "from" => [0, rank],
      "to" => [3, rank]
    })
  end

  def castling_move(board, %{"from" => [4, rank], "to" => [6, _rank]}) do
    move_piece(board, %{
      "from" => [7, rank],
      "to" => [5, rank]
    })
  end

  def default do
    %{
      "0,7" => %{"type" => "rook", "colour" => "black"},
      "1,7" => %{"type" => "knight", "colour" => "black"},
      "2,7" => %{"type" => "bishop", "colour" => "black"},
      "3,7" => %{"type" => "queen", "colour" => "black"},
      "4,7" => %{"type" => "king", "colour" => "black"},
      "5,7" => %{"type" => "bishop", "colour" => "black"},
      "6,7" => %{"type" => "knight", "colour" => "black"},
      "7,7" => %{"type" => "rook", "colour" => "black"},
      "0,6" => %{"type" => "pawn", "colour" => "black"},
      "1,6" => %{"type" => "pawn", "colour" => "black"},
      "2,6" => %{"type" => "pawn", "colour" => "black"},
      "3,6" => %{"type" => "pawn", "colour" => "black"},
      "4,6" => %{"type" => "pawn", "colour" => "black"},
      "5,6" => %{"type" => "pawn", "colour" => "black"},
      "6,6" => %{"type" => "pawn", "colour" => "black"},
      "7,6" => %{"type" => "pawn", "colour" => "black"},
      "0,1" => %{"type" => "pawn", "colour" => "white"},
      "1,1" => %{"type" => "pawn", "colour" => "white"},
      "2,1" => %{"type" => "pawn", "colour" => "white"},
      "3,1" => %{"type" => "pawn", "colour" => "white"},
      "4,1" => %{"type" => "pawn", "colour" => "white"},
      "5,1" => %{"type" => "pawn", "colour" => "white"},
      "6,1" => %{"type" => "pawn", "colour" => "white"},
      "7,1" => %{"type" => "pawn", "colour" => "white"},
      "0,0" => %{"type" => "rook", "colour" => "white"},
      "1,0" => %{"type" => "knight", "colour" => "white"},
      "2,0" => %{"type" => "bishop", "colour" => "white"},
      "3,0" => %{"type" => "queen", "colour" => "white"},
      "4,0" => %{"type" => "king", "colour" => "white"},
      "5,0" => %{"type" => "bishop", "colour" => "white"},
      "6,0" => %{"type" => "knight", "colour" => "white"},
      "7,0" => %{"type" => "rook", "colour" => "white"}
    }
  end

  defp to_index({file, rank}) do
    "#{file},#{rank}"
  end

  defp indexes_to_tuples(list) do
    list
    |> Enum.map(fn {index, _piece} -> index_to_tuple(index) end)
  end

  defp index_to_tuple(index) do
    index
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
    |> List.to_tuple()
  end
end
