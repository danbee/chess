defmodule Chess.SessionTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query
  import Chess.Factory

  test "user cannot log in with incorrect email", %{session: session} do
    insert(:user, %{email: "link@hyrule.kingdom", password: "ilovezelda"})

    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Log in"))
    |> fill_in(text_field("Email"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))

    assert session |> has_text?("Bad email or password")
  end

  test "user cannot log in with incorrect password", %{session: session} do
    insert(:user, %{email: "link@hyrule.kingdom", password: "ilovezelda"})

    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Log in"))
    |> fill_in(text_field("Email"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "calamityganon")
    |> click(button("Log in"))

    assert session |> has_text?("Bad email or password")
  end

  test "user can log in with correct details", %{session: session} do
    insert(:user, %{email: "link@hyrule.kingdom", password: "ilovezelda"})

    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Log in"))
    |> fill_in(text_field("Email"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))

    assert session |> has_text?("You are logged in")
    assert session |> has_text?("Listing games")
    assert session |> has_text?("link@hyrule.kingdom")
  end

  test "user can log out", %{session: session} do
    insert(:user, %{email: "link@hyrule.kingdom", password: "ilovezelda"})

    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Log in"))
    |> fill_in(text_field("Email"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Log in"))

    session
    |> visit("/")
    |> click(link("Log out"))

    assert session |> has_text?("You are logged out")
  end
end
