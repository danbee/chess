defmodule Chess.GamesTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query, only: [css: 1, css: 2, button: 1]

  test "visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("header h1", text: "Chess"))
  end

  test "can create a new game", %{session: session} do
    session
    |> create_game()
    |> assert_has(css(".board"))
  end

  test "can move a piece", %{session: session} do
    session
    |> create_game()

    session
    |> click(css("#f4-r1"))
    |> assert_has(square_selected("f4-r1"))
    |> assert_has(square_containing("f4-r1", "white.pawn"))

    session
    |> click(css("#f4-r3"))
    |> refute_has(square_containing("f4-r1", "white.pawn"))
    |> assert_has(square_containing("f4-r3", "white.pawn"))
  end

  defp create_game(session) do
    session
    |> visit("/games")
    |> click(button("Create game"))
  end

  defp square_selected(square) do
    css("##{square}.selected")
  end

  defp square_containing(square, piece) do
    css("##{square}.#{piece}")
  end
end
