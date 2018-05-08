defmodule Chess.Features.MovesTest do
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

    |> click(css("#f4-r1"))
    |> assert_has(square_selected("f4-r1"))
    |> assert_has(square_containing("f4-r1", "white.pawn"))

    # TODO: Random failure, Investigate!
    |> click(css("#f4-r3"))
    |> assert_has(square_containing("f4-r3", "white.pawn"))
    |> refute_has(square_containing("f4-r1", "white.pawn"))
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

  test "cannot move the king into a position that would result in check",
       %{session: session} do
    user = insert(:user, %{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    })
    opponent = insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })
    insert(:game, %{
      board: %{
        "4,0" => %{"type" => "king",   "colour" => "white"},
        "3,7" => %{"type" => "queen",  "colour" => "black"},
      },
      user_id: user.id,
      opponent_id: opponent.id,
      turn: "white",
    })

    session
    |> login("link@hyrule.com", "ilovezelda")
    |> visit("/games")
    |> click(link("Game with Zelda"))

    session
    |> click(css("#f4-r0"))
    |> click(css("#f3-r0"))
    |> refute_has(square_containing("f3-r0", "white.king"))
    |> assert_has(square_containing("f4-r0", "white.king"))
  end

  test "cannot make a move that would place the king in check",
       %{session: session} do
    user = insert(:user, %{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    })
    opponent = insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })
    insert(:game, %{
      board: %{
        "4,0" => %{"type" => "king", "colour" => "white"},
        "4,1" => %{"type" => "rook", "colour" => "white"},
        "4,7" => %{"type" => "queen", "colour" => "black"},
      },
      user_id: user.id,
      opponent_id: opponent.id,
      turn: "white",
    })

    session
    |> login("link@hyrule.com", "ilovezelda")
    |> visit("/games")
    |> click(link("Game with Zelda"))

    session
    |> click(css("#f4-r1"))
    |> click(css("#f2-r1"))
    |> refute_has(square_containing("f2-r1", "white.rook"))
    |> assert_has(square_containing("f4-r1", "white.rook"))
  end

  test "user is informed when the game is in check", %{session: session} do
    user = insert(:user, %{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    })
    opponent = insert(:user, %{
      name: "Zelda",
      email: "zelda@hyrule.com",
      password: "ganonsucks"
    })
    insert(:game, %{
      board: %{
        "4,0" => %{"type" => "king",   "colour" => "white"},
        "3,7" => %{"type" => "queen",  "colour" => "black"},
        "7,7" => %{"type" => "king",  "colour" => "black"},
      },
      user_id: user.id,
      opponent_id: opponent.id,
      turn: "black",
    })

    session
    |> login("zelda@hyrule.com", "ganonsucks")
    |> visit("/games")
    |> click(link("Game with Link"))

    session
    |> click(css("#f3-r7"))
    |> click(css("#f4-r7"))
    |> assert_has(square_containing("f4-r7", "black.queen"))

    assert session |> has_text?("Check")
  end

  defp square_selected(square) do
    css("##{square}.selected")
  end

  defp square_containing(square, piece) do
    css("##{square}.#{piece}")
  end
end
