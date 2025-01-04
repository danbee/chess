import Config

config :chess, ChessWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  check_origin: ["https://chess.danbee.in", "https://64squares.club"],
  http: [port: {:system, "PORT"}],
  root: "./assets",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  server: true,
  url: [scheme: "https", host: System.get_env("HOST"), port: System.get_env("URL_PORT")],
  version: Application.spec(:chess, :vsn)

config :chess, Chess.Mailer,
  adapter: Bamboo.MailgunAdapter,
  api_key: System.get_env("MAILGUN_API_KEY"),
  domain: System.get_env("MAILGUN_DOMAIN")

config :chess, Chess.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  database: "",
  ssl: false,
  pool_size: 1
