defmodule Chess.RegistrationTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query

  test "user can register", %{session: session} do
    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Register"))
    |> fill_in(text_field("Name"), with: "Link")
    |> fill_in(text_field("Email"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Register"))

    assert session |> has_text?("Registered successfully")
  end

  test "user cannot register without a name", %{session: session} do
    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Register"))
    |> fill_in(text_field("Email"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Register"))

    session
    |> assert_has(
      css("[data-role='name-error']", text: "can't be blank")
    )
  end

  test "user cannot register without an email", %{session: session} do
    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Register"))
    |> fill_in(text_field("Name"), with: "Link")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Register"))

    session
    |> assert_has(
      css("[data-role='email-error']", text: "can't be blank")
    )
  end

  test "user cannot register without a password", %{session: session} do
    session
    |> visit("/")
    |> click(css(".user-nav a", text: "Register"))
    |> fill_in(text_field("Name"), with: "Link")
    |> fill_in(text_field("Email"), with: "link@example.com")
    |> click(button("Register"))

    session
    |> assert_has(
      css("[data-role='password-error']", text: "can't be blank")
    )
  end
end
