defmodule LiveViewExampleUsageWeb.Presence do
  use Phoenix.Presence,
    otp_app: :live_view_example_usage,
    pubsub_server: LiveViewExampleUsage.PubSub
end
