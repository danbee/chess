# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# General application configuration
config :chess,
  ecto_repos: [Chess.Repo]

# Configures the endpoint
config :chess, ChessWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iiTDTKorCWTFoeBgAkr35XZp22cNIM2RsmnHiHdzKAuSHXUGXx42z7lawAwiu1B1",
  render_errors: [view: ChessWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Chess.PubSub,
           adapter: Phoenix.PubSub.PG2]

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
    translate_error_module: ChessWeb.ErrorHelpers

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
