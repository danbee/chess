defmodule Chess.SessionTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1]
  import Chess.Factory, only: [create_user: 0]

  test "user cannot log in with incorrect username", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))

    assert session |> has_text?("Bad username or password")
  end

  test "user cannot log in with incorrect password", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "calamityganon")
    |> click(button("Log in"))

    assert session |> has_text?("Bad username or password")
  end

  test "user can log in with correct details", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))

    assert session |> has_text?("You are logged in")
    assert session |> has_text?("Listing games")
    assert session |> has_text?("link@hyrule.kingdom")
  end

  test "user can log out", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))

    session
    |> visit("/")
    |> click(link("Log out"))

    assert session |> has_text?("You are logged out")
  end
end
