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
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "zelda")
    |> click(button("Create game"))

    session
    |> assert_has(css("h2", text: "Game with zelda"))
    |> assert_has(css(".board"))
  end

  test "can only see own games", %{session: session} do
    opponent = create_user("urbosa", "gerudoqueen")

    user = create_user("zelda", "ganonsucks")
    create_game_for(user, opponent)

    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "urbosa")
    |> click(button("Create game"))
    |> click(link("Back to games"))

    session
    |> assert_has(css(".table tr", count: 1))
    |> assert_has(link("Game with urbosa"))
  end

  test "can see games as an opponent", %{session: session} do
    opponent = create_user("urbosa", "gerudoqueen")

    user = create_user("zelda", "ganonsucks")
    create_game_for(user, opponent)

    session
    |> login("urbosa", "gerudoqueen")

    session
    |> assert_has(css(".table tr", count: 1))
    |> assert_has(link("Game with zelda"))

    session
    |> click(link("Game with zelda"))

    session
    |> assert_has(css("h2", text: "Game with zelda"))
  end

  test "can move a piece", %{session: session} do
    create_user("zelda", "ganonsucks")

    session
    |> create_user_and_login()
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

  test "cannot move the opponents pieces", %{session: session} do
    create_user("zelda", "ganonsucks")

    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "zelda")
    |> click(button("Create game"))

    session
    |> click(css("#f4-r6"))
    |> refute_has(square_selected("f4-r5"))
  end

  test "cannot move pieces when it's the opponents turn", %{session: session} do
    create_user("link", "ilovezelda")
    create_user("zelda", "ganonsucks")

    session
    |> login("link", "ilovezelda")
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "zelda")
    |> click(button("Create game"))

    {:ok, session2} = Wallaby.start_session
    session2
    |> login("zelda", "ganonsucks")
    |> click(link("Game with link"))

    session2
    |> click(css("#f4-r6"))
    |> refute_has(square_selected("f4-r5"))
  end

  test "move is reflected on opponents screen", %{session: session} do
    create_user("link", "ilovezelda")
    create_user("zelda", "ganonsucks")

    session
    |> login("link", "ilovezelda")
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "zelda")
    |> click(button("Create game"))

    {:ok, session2} = Wallaby.start_session
    session2
    |> login("zelda", "ganonsucks")
    |> click(link("Game with link"))

    session
    |> click(css("#f4-r1"))
    |> click(css("#f4-r3"))

    session2
    |> assert_has(css(".board.black-to-move"))
    |> refute_has(square_containing("f4-r1", "white.pawn"))
    |> assert_has(square_containing("f4-r3", "white.pawn"))
  end

  defp create_user_and_login(session) do
    create_user("link", "ilovezelda")

    session
    |> login("link", "ilovezelda")
  end

  defp login(session, username, password) do
    session
    |> visit("/session/new")
    |> fill_in(text_field("Username"), with: username)
    |> fill_in(text_field("Password"), with: password)
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
