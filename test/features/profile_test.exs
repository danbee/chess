defmodule Chess.Features.ProfileTest do
  use ChessWeb.FeatureCase

  import Wallaby.Query
  import Chess.Factory

  import Chess.AuthenticationHelpers

  test "user can update their details", %{session: session} do
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
    |> fill_in(text_field("Name"), with: "Not Zelda")
    |> click(button("Update Profile"))

    assert session |> has_text?("Not Zelda")
  end

  test "name cannot be blank", %{session: session} do
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
    |> fill_in(text_field("Name"), with: "")
    |> click(button("Update Profile"))

    session
    |> assert_has(css("[data-role='name-error']", text: "can't be blank"))
  end

  test "email cannot be blank", %{session: session} do
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
    |> fill_in(text_field("Email"), with: "")
    |> click(button("Update Profile"))

    session
    |> assert_has(css("[data-role='email-error']", text: "can't be blank"))
  end
end
