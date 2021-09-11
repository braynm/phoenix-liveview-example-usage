defmodule LiveViewExampleUsage do
  @moduledoc """
  LiveViewExampleUsage keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc """
  Unsplash client based on environment (e.g. dev, prod)
  """
  def unsplash_client() do
    Application.get_env(:live_view_example_usage, :unsplash_api)
  end
end
