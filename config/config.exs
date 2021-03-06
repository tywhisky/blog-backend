# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :os_blog,
  ecto_repos: [OsBlog.Repo]

# Configures the endpoint
config :os_blog, OsBlogWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: OsBlogWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: OsBlog.PubSub,
  live_view: [signing_salt: "/gstwazU"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :os_blog, OsBlog.Guardian,
  issuer: "os_blog",
  secret_key: "0pfw8Ou4LpaWzdVEIQZ/nhyZ+Za6rGfoIwVZeyJi80cv6SZTMWp83WjE2VN7i5Zm"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
