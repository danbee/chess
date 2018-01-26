defmodule Chess.RegistrationTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1]

  test "user can register", %{session: session} do
    session
    |> visit("/")
    |> click(link("Register"))
    |> fill_in(text_field("Username"), with: "link@example.com")
    |> fill_in(text_field("Password"), with: "ilovezelda")
    |> click(button("Register"))

    assert session |> has_text?("Registered successfully")
  end
end
