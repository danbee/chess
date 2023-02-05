defmodule ChessWeb.Api.OpponentsController do
  use ChessWeb, :controller

  import Chess.Auth, only: [current_user: 1]
  alias Chess.Repo
  alias Chess.Repo.Queries

  def index(conn, %{"q" => query_string}) do
    opponents =
      conn
      |> current_user()
      |> Queries.opponents(query_string)
      |> Repo.all()

    render(conn, "index.json", %{opponents: opponents})
  end
end
