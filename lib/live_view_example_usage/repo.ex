defmodule LiveViewExampleUsage.Repo do
  use Ecto.Repo,
    otp_app: :live_view_example_usage,
    adapter: Ecto.Adapters.Postgres
end
