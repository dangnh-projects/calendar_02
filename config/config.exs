# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :calendar_02,
  ecto_repos: [Calendar02.Repo]

# Configures the endpoint
config :calendar_02, Calendar02Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ooE61XVa6Uph1ar3sr9EuyEo8/cPXlEg8lq0OX0NpBevrMclCOSzKd66H7wJ5FNL",
  render_errors: [view: Calendar02Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Calendar02.PubSub,
  live_view: [signing_salt: "c26ke3k2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
