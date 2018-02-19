use Mix.Config

config :chess, Chess.Endpoint,
  load_from_system_env: true,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :chess, Chess.Endpoint,
  server: true,
  secret_key_base: "${SECRET_KEY_BASE}"

config :chess, Chess.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  ssl: true,
  pool_size: 1
