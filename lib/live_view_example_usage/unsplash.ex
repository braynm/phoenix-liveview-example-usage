defmodule LiveViewExampleUsage.UnsplashBehaviour do
  @callback search_photo(map()) :: {:ok, term} | {:error, any()}
end

defmodule LiveViewExampleUsage.Unsplash do
  @behaviour LiveViewExampleUsage.UnsplashBehaviour

  use Tesla
  plug Tesla.Middleware.BaseUrl, "https://api.unsplash.com"
  plug Tesla.Middleware.Headers, [{"authorization", "Client-ID #{client_id()}"}]
  plug Tesla.Middleware.JSON

  @doc """
  Retrieve photos from Unsplash API
  """
  # def search_photos(query) do
  def search_photo(query: query, page: page, per_page: per_page = params) do
    case get("/search/photos?query=#{URI.encode(query)}&per_page=#{per_page}&page=#{page}") do
      {:ok, %Tesla.Env{status: 200, body: response}} ->
        {:ok, {extract_list(response["results"]), %{"total_pages" => response["total_pages"]}}}

      {:ok, %Tesla.Env{status: status}} when status > 299 ->
        {:error, {:invalid_request, status}}
    end
  end

  def search_photo(_), do: {:error, :invalid_params}

  defp extract_list(results) when is_list(results) do
    Enum.map(results, fn item ->
      %{
        id: item["id"],
        url: item["urls"]["small"],
        description: item["description"],
        blur_hash: item["blur_hash"],
        width: item["width"],
        height: item["height"]
      }
    end)
  end

  defp extract_items(_), do: []

  def client_id do
    Application.get_env(:live_view_example_usage, :unsplash_credentials)[:client_id]
  end
end
