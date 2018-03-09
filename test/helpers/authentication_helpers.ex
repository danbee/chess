defmodule Chess.AuthenticationHelpers do
  use Wallaby.DSL

  import Wallaby.Query

  import Chess.Factory

  def create_user_and_login(session) do
    insert(:user, %{
      name: "Link",
      email: "link@hyrule.com",
      password: "ilovezelda"
    })

    session
    |> login("link@hyrule.com", "ilovezelda")
  end

  def login(session, email, password) do
    session
    |> visit("/session/new")
    |> fill_in(text_field("Email"), with: email)
    |> fill_in(text_field("Password"), with: password)
    |> click(button("Log in"))
  end
end
