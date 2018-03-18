defmodule Chess.Board do
  @moduledoc false

  def transform(board) do
    Enum.map(0..7, fn (rank) ->
      Enum.map(0..7, fn (file) ->
        board["#{file},#{rank}"]
      end)
    end)
  end

  def search(board, %{"type" => type, "colour" => colour}) do
    board
    |> Enum.filter(fn({_index, piece}) ->
      match?(%{"type" => ^type, "colour" => ^colour}, piece)
    end)
    |> Enum.map(fn({index, _piece}) -> index_to_tuple(index) end)
  end

  def piece(board, {file, rank}) do
    board["#{file},#{rank}"]
  end

  def move_piece(board, move_params) do
    [from_file, from_rank] = move_params["from"]
    [to_file, to_rank] = move_params["to"]

    {piece, board} = Map.pop(board, "#{from_file},#{from_rank}")

    Map.put(board, "#{to_file},#{to_rank}", piece)
  end

  def default do
    %{
      "0,7" => %{"type" => "rook",   "colour" => "black"},
      "1,7" => %{"type" => "knight", "colour" => "black"},
      "2,7" => %{"type" => "bishop", "colour" => "black"},
      "3,7" => %{"type" => "queen",  "colour" => "black"},
      "4,7" => %{"type" => "king",   "colour" => "black"},
      "5,7" => %{"type" => "bishop", "colour" => "black"},
      "6,7" => %{"type" => "knight", "colour" => "black"},
      "7,7" => %{"type" => "rook",   "colour" => "black"},

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

      "0,0" => %{"type" => "rook",   "colour" => "white"},
      "1,0" => %{"type" => "knight", "colour" => "white"},
      "2,0" => %{"type" => "bishop", "colour" => "white"},
      "3,0" => %{"type" => "queen",  "colour" => "white"},
      "4,0" => %{"type" => "king",   "colour" => "white"},
      "5,0" => %{"type" => "bishop", "colour" => "white"},
      "6,0" => %{"type" => "knight", "colour" => "white"},
      "7,0" => %{"type" => "rook",   "colour" => "white"}
    }
  end

  defp index_to_tuple(index) do
    index
    |> String.split(",")
    |> Enum.map(&(String.to_integer(&1)))
    |> List.to_tuple
  end
end
