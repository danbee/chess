defmodule ChessWeb.SquareView do
  use ChessWeb, :view

  def classes(_file, _rank, piece, selected, available) do
    square_class()
    |> add_piece_classes(piece)
    |> add_selected_class(selected)
    |> add_available_class(available)
    |> Enum.join(" ")
  end

  defp square_class do
    ["square"]
  end

  defp add_piece_classes(classes, piece) do
    if piece != nil do
      classes ++ ["square--#{piece["type"]}", "square--#{piece["colour"]}"]
    else
      classes
    end
  end

  defp add_selected_class(classes, selected) do
    if selected do
      classes ++ ["square--selected"]
    else
      classes
    end
  end

  defp add_available_class(classes, available) do
    if available do
      classes ++ ["square--available"]
    else
      classes
    end
  end
end
