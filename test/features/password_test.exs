defmodule Chess.Features.PasswordTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query
  import Chess.Factory

  import Chess.AuthenticationHelpers

  test "user can change their password", %{session: session} do
    user =
      insert(:user, %{
        name: "Link",
        email: "link@hyrule.com",
        password: "ilovezelda"
      })

    session
    |> login(user.email, "ilovezelda")

    session
    |> click(link(user.name))
    |> click(link("Change password"))
    |> fill_in(text_field("Password"), with: "ganonsucks")
    |> click(button("Update Password"))

    assert session |> has_text?("Password updated successfully")
  end

  test "password cannot be blank", %{session: session} do
    user =
      insert(:user, %{
        name: "Link",
        email: "link@hyrule.com",
        password: "ilovezelda"
      })

    session
    |> login(user.email, "ilovezelda")

    session
    |> click(link(user.name))
    |> click(link("Change password"))
    |> click(button("Update Password"))

    session
    |> assert_has(css("[data-role='password-error']", text: "can't be blank"))
  end
end
