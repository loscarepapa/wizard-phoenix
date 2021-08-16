# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :genio_test,
  ecto_repos: [GenioTest.Repo]

# Configures the endpoint
config :genio_test, GenioTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U+Ca9Lt1WW5iunNatR0o4iMWkg1VW6sQMXG/ac5JlCqm+xMCIMb42jb1DSFVB88t",
  render_errors: [view: GenioTestWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GenioTest.PubSub,
  live_view: [signing_salt: "oKyhZ7Pe"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :genio_test, :templates, %{
  step_1: "index.html", 
  step_2: "customer.html", 
  step_3: "vehicle.html", 
  step_4: %{
    qualitas: "qualitas.html",
    gnp: "gnp.html",
    axa: "axa.html",
    aba: "aba.html"
  },
  step_5: "issue.html"
}

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
