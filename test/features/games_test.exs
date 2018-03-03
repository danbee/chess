defmodule Chess.GamesTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query

  import Chess.Factory

  test "visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("header h1", text: "Chess"))
  end

  test "can create a new game", %{session: session} do
    insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })

    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "Zelda")
    |> click(button("Create game"))

    session
    |> assert_has(css("h2", text: "Game with Zelda"))
    |> assert_has(css(".board"))
  end

  test "can only see own games", %{session: session} do
    opponent = insert(:user, %{
      name: "Urbosa",
      email: "urbosa@gerudo.town",
      password: "gerudoqueen"
    })
    user = insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })
    insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "Urbosa")
    |> click(button("Create game"))
    |> click(link("Back to games"))

    session
    |> assert_has(css(".table tr", count: 1))
    |> assert_has(link("Game with Urbosa"))
  end

  test "can see games as an opponent", %{session: session} do
    opponent = insert(:user, %{
      name: "Urbosa",
      email: "urbosa@gerudo.town",
      password: "gerudoqueen"
    })
    user = insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })
    insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    session
    |> login("urbosa@gerudo.town", "gerudoqueen")

    session
    |> assert_has(css(".table tr", count: 1))
    |> assert_has(link("Game with Zelda"))

    session
    |> click(link("Game with Zelda"))

    session
    |> assert_has(css("h2", text: "Game with Zelda"))
  end

  test "can move a piece", %{session: session} do
    insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })

    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "Zelda")
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
    insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })

    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "Zelda")
    |> click(button("Create game"))

    session
    |> click(css("#f4-r6"))
    |> refute_has(square_selected("f4-r5"))
  end

  test "cannot move pieces when it's the opponents turn", %{session: session} do
    insert(:user, %{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    })
    insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })

    session
    |> login("link@hyrule.com", "ilovezelda")
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "Zelda")
    |> click(button("Create game"))

    {:ok, session2} = Wallaby.start_session
    session2
    |> login("zelda@hyrule.com", "ganonsucks")
    |> click(link("Game with Link"))

    session2
    |> click(css("#f4-r6"))
    |> refute_has(square_selected("f4-r5"))
  end

  test "move is reflected on opponents screen", %{session: session} do
    insert(:user, %{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    })
    insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })

    session
    |> login("link@hyrule.com", "ilovezelda")
    |> visit("/games")
    |> click(link("New game"))
    |> select("game[opponent_id]", option: "Zelda")
    |> click(button("Create game"))

    {:ok, session2} = Wallaby.start_session
    session2
    |> login("zelda@hyrule.com", "ganonsucks")
    |> click(link("Game with Link"))

    session
    |> click(css("#f4-r1"))
    |> click(css("#f4-r3"))

    session2
    |> assert_has(css(".board.black-to-move"))
    |> refute_has(square_containing("f4-r1", "white.pawn"))
    |> assert_has(square_containing("f4-r3", "white.pawn"))
  end

  defp create_user_and_login(session) do
    insert(:user, %{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    })

    session
    |> login("link@hyrule.com", "ilovezelda")
  end

  defp login(session, email, password) do
    session
    |> visit("/session/new")
    |> fill_in(text_field("Email"), with: email)
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
