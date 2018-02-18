defmodule Chess.GamesTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query

  import Chess.Factory, only: [create_user: 2, create_game_for: 2]

  test "visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("header h1", text: "Chess"))
  end

  test "can create a new game", %{session: session} do
    create_user("zelda", "ganonsucks")

    session
    |> login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "zelda")
    |> click(button("Create game"))

    session
    |> assert_has(css(".board"))
  end

  test "can only see own games", %{session: session} do
    opponent = create_user("urbosa", "gerudoqueen")

    user = create_user("zelda", "ganonsucks")
    create_game_for(user, opponent)

    session
    |> login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "urbosa")
    |> click(button("Create game"))
    |> click(link("Back to games"))

    session
    |> assert_has(css(".table tr", count: 1))
  end

  test "can move a piece", %{session: session} do
    create_user("zelda", "ganonsucks")

    session
    |> login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "zelda")
    |> click(button("Create game"))

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
    create_user("link", "ilovezelda")

    session
    |> visit("/session/new")
    |> fill_in(text_field("Username"), with: "link")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))
  end

  def select(session, name, [option: option]) do
    session
    |> find(css("[name='#{name}']"))
    |> click(option(option))

    session
  end

  defp square_selected(square) do
    css("##{square}.selected")
  end

  defp square_containing(square, piece) do
    css("##{square}.#{piece}")
  end
end
