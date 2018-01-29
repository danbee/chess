defmodule Chess.SessionTest do
  use ChessWeb.FeatureCase

  alias Chess.Auth.User

  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1]

  test "user cannot sign in with incorrect username", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Sign in"))

    assert session |> has_text?("Bad username or password")
  end

  test "user cannot sign in with incorrect password", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "calamityganon")
    |> click(button("Sign in"))

    assert session |> has_text?("Bad username or password")
  end

  test "user can sign in with correct details", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Sign in"))

    assert session |> has_text?("You are signed in")
    assert session |> has_text?("Listing games")
    assert session |> has_text?("link@hyrule.kingdom")
  end

  test "user can sign out", %{session: session} do
    create_user()

    session
    |> visit("/")
    |> click(link("Log in"))
    |> fill_in(text_field("Username"), with: "link@hyrule.kingdom")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Sign in"))

    session
    |> visit("/")
    |> click(link("Log out"))

    assert session |> has_text?("You are logged out")
  end

  defp create_user() do
    changeset = User.changeset(
      %User{},
      %{username: "link@hyrule.kingdom", password: "ilovezelda"}
    )
    Repo.insert!(changeset)
  end
end
