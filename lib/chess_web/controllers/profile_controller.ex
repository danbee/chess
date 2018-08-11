defmodule ChessWeb.ProfileController do
  @moduledoc false

  use ChessWeb, :controller

  import Chess.Auth, only: [current_user: 1]

  alias Chess.Store.User

  def edit(conn, _params) do
    changeset = User.changeset(current_user(conn), %{})

    conn
    |> render("edit.html", changeset: changeset)
  end

  def update(conn, %{"user" => user}) do
    changeset = User.profile_changeset(current_user(conn), user)

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, gettext("Profile updated successfully."))
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end
end
