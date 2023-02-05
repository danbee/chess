defmodule ChessWeb.RegistrationController do
  use ChessWeb, :controller

  alias Chess.Auth.Guardian
  alias Chess.Store.User

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user}) do
    changeset = User.changeset(%User{}, user)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Registered successfully.")
        |> redirect(to: page_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
