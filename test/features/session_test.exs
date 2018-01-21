defmodule Chess.SessionTest do
  use ChessWeb.FeatureCase

  alias Chess.Auth.User

  import Wallaby.Query, only: [text_field: 1, button: 1]

  test "user cannot sign in with incorrect password", %{session: session} do
    create_user()

    session
    |> visit("/session/new")
    |> fill_in(text_field("Username"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "calamityganon")
    |> click(button("Sign in"))

    assert session |> has_text?("Bad username or password")
  end

  test "user can sign in with correct details", %{session: session} do
    create_user()

    session
    |> visit("/session/new")
    |> fill_in(text_field("Username"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Sign in"))

    assert session |> has_text?("You are signed in")
  end

  defp create_user() do
    changeset = User.changeset(
      %User{},
      %{username: "link@example.com", password: "ilovezelda"}
    )
    Repo.insert!(changeset)
  end
end
