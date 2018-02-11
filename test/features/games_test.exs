defmodule Chess.GamesTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query, only: [
    css: 1,
    css: 2,
    button: 1,
    text_field: 1,
    link: 1,
  ]
  import Chess.Factory, only: [create_user: 2, create_game_for: 1]

  test "visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("header h1", text: "Chess"))
  end

  test "can create a new game", %{session: session} do
    session
    |> login()
    |> create_game()
    |> assert_has(css(".board"))
  end

  test "can only see own games", %{session: session} do
    user = create_user("zelda@hyrule.kingdom", "ganonsucks")
    create_game_for(user)

    session
    |> login()
    |> create_game()
    |> click(link("Back to games"))
    |> assert_has(css(".table tr", count: 1))
  end

  test "can move a piece", %{session: session} do
    session
    |> login()
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

  defp login(session) do
    create_user("link@hyrule.kingdom", "ilovezelda")

    session
    |> visit("/session/new")
    |> fill_in(text_field("Username"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))
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
