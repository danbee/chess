defmodule Chess.Features.GamesTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query
  import Chess.Factory

  import Chess.AuthenticationHelpers
  import Chess.FormHelpers

  test "visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("header h1", text: "64squares"))
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
    |> select_opponent("Zelda")
    |> click(button("Create game"))

    session
    |> assert_has(css("p", text: "Playing Zelda"))
    |> assert_has(css(".board"))
  end

  test "cannot create a game without an opponent", %{session: session} do
    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> click(button("Create game"))

    session
    |> assert_has(css(".help-block", text: "can't be blank"))
  end

  test "can only see own games", %{session: session} do
    opponent =
      insert(:user, %{
        name: "Urbosa",
        email: "urbosa@gerudo.town",
        password: "gerudoqueen"
      })

    user =
      insert(:user, %{
        name: "Zelda",
        email: "zelda@hyrule.com",
        password: "ganonsucks"
      })

    insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    session
    |> create_user_and_login()
    |> visit("/games")
    |> click(link("New game"))
    |> select_opponent("Urbosa")
    |> click(button("Create game"))
    |> click(link("64squares"))

    session
    |> assert_has(css(".games-list tr", count: 1))
    |> assert_has(link("Game with Urbosa"))
  end

  test "can see games as an opponent", %{session: session} do
    opponent =
      insert(:user, %{
        name: "Urbosa",
        email: "urbosa@gerudo.town",
        password: "gerudoqueen"
      })

    user =
      insert(:user, %{
        name: "Zelda",
        email: "zelda@hyrule.com",
        password: "ganonsucks"
      })

    insert(:game, %{user_id: user.id, opponent_id: opponent.id})

    session
    |> login("urbosa@gerudo.town", "gerudoqueen")

    session
    |> assert_has(css(".games-list tr", count: 1))
    |> assert_has(link("Game with Zelda"))

    session
    |> click(link("Game with Zelda"))

    session
    |> assert_has(css("p", text: "Playing Zelda"))
  end
end
