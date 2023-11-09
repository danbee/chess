import Config

config :chess, ChessWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline
      --watch)]},
    sass:
      {DartSass, :install_and_run,
       [:default, ~w(--embed-source-map --source-map-urls=absolute --watch)]}
  ]

config :chess, ChessWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/chess_web/views/.*(ex)$},
      ~r{lib/chess_web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :chess, Chess.Mailer, adapter: Bamboo.LocalAdapter

config :chess, Chess.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "chess_dev",
  hostname: "localhost",
  pool_size: 10
