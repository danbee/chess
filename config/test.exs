use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chess, ChessWeb.Endpoint,
  check_origin: false,
  http: [port: 4001],
  server: true

config :chess, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

config :chess, Chess.Mailer,
  adapter: Bamboo.TestAdapter

# Configure your database
config :chess, Chess.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "chess_test",
  hostname: "localhost",
  port: System.get_env("POSTGRES_PORT") || "5432",
  pool: Ecto.Adapters.SQL.Sandbox
