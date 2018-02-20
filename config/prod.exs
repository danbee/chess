use Mix.Config

config :chess, ChessWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "localhost", port: {:system, "PORT"}],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: "./assets",
  version: Application.spec(:myapp, :vsn),
  secret_key_base: "${SECRET_KEY_BASE}"

config :chess, Chess.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  pool_size: 1
