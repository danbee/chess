defmodule Chess.MovesTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query

  import Chess.Factory

  import Chess.AuthenticationHelpers
  import Chess.FormHelpers

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

  defp square_selected(square) do
    css("##{square}.selected")
  end

  defp square_containing(square, piece) do
    css("##{square}.#{piece}")
  end
end
