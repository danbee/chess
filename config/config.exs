# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

config :phoenix, :json_library, Jason

# General application configuration
config :chess,
  ecto_repos: [Chess.Repo]

# Configures the endpoint
config :chess, ChessWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iiTDTKorCWTFoeBgAkr35XZp22cNIM2RsmnHiHdzKAuSHXUGXx42z7lawAwiu1B1",
  render_errors: [view: ChessWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Chess.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure authentication provider
# Replace secret_key in prod.secret.exs
config :chess, Chess.Auth.Guardian,
  issuer: "chess",
  secret_key: "vd2vXkrYTTFKSKmNMoS2/Hk4Fxn8BkyzsVArRkxJazdQ3mr6bI4YgAC6f8ODiWlM"

config :formulator,
  validate: false,
  translate_error_module: ChessWeb.ErrorHelpers

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.5",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*  --loader:.js=jsx),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure dart_sass
config :dart_sass,
  version: "1.54.5",
  default: [
    args: ~w(css/app.scss ../priv/static/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
