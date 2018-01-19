{:ok, _} = Application.ensure_all_started(:wallaby)

ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Chess.Repo, :manual)

Application.put_env(:wallaby, :base_url, ChessWeb.Endpoint.url)
