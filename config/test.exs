use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :live_view_example_usage, LiveViewExampleUsage.Repo,
  username: "Bryan",
  password: "",
  database: "live_view_example_usage_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_view_example_usage, LiveViewExampleUsageWeb.Endpoint,
  http: [port: 4000],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :live_view_example_usage, :unsplash_api, LiveViewExampleUsage.UnsplashMock
