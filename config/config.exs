# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :git_trendex,
  ecto_repos: [GitTrendex.Db.Repo],
  trending_url: "https://github.com/trending?since=daily"

# Configures the endpoint
config :git_trendex, GitTrendexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2TgkSEv6XEGNyT5MBEyKzb4gtSu7O7x9GfBaQaBTFQ9s3wnlcjCPTXYPTS4GFb+r",
  render_errors: [view: GitTrendexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GitTrendex.PubSub,
  live_view: [signing_salt: "TzvpDYBn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "config.secret.exs"
import_config "#{Mix.env()}.exs"
