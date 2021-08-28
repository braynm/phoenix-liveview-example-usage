defmodule LiveViewExampleUsage do
  @moduledoc """
  LiveViewExampleUsage keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """


  @doc """``
  Gets the Unsplash API credentials from env
  """
  def unsplash_credentials do
    {
      System.get_env!(@unsplash_access_key),
      System.get_env!(@secret_key),
    }
  end
end
