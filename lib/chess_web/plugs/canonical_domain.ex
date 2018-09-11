defmodule ChessWeb.Plugs.CanonicalDomain do
  @moduledoc false

  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _options) do
    if conn.host != canonical_host() do
      conn
      |> put_status(:moved_permanently)
      |> Phoenix.Controller.redirect(external: canonical_domain(conn))
      |> halt()
    else
      conn
    end
  end

  defp canonical_domain(conn) do
    "//#{canonical_host()}#{conn.request_path}"
  end

  defp canonical_host() do
    ChessWeb.Endpoint.config(:url)[:host]
  end
end
