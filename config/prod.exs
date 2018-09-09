use Mix.Config

config :chess, ChessWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  check_origin: ["https://chess.danbarber.me", "https://64squares.club"],
  http: [port: {:system, "PORT"}],
  root: "./assets",
  secret_key_base: "${SECRET_KEY_BASE}",
  server: true,
  url: [host: "localhost", port: {:system, "PORT"}],
  version: Application.spec(:chess, :vsn)

config :chess, Chess.Mailer,
  adapter: Bamboo.MailgunAdapter

config :chess, Chess.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  ssl: true,
  pool_size: 1
