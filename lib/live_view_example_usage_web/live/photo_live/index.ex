defmodule LiveViewExampleUsageWeb.PhotoLive.Index do
  use Phoenix.LiveView
  alias LiveViewExampleUsage.Unsplash.SearchPhoto

  def mount(_params, %{"page_id" => page_id}, socket) do
    socket =
      socket
      |> assign(fetching_photo: true)
      |> assign(query: nil)
      |> assign(update_action: @default_update_action)

    {:ok, socket, temporary_assigns: [photos: []]}
  end

  def handle_event("search", %{"value" => value}, socket) do
    unsplash_client = LiveViewExampleUsage.unsplash_client()

    search = [
      query: value,
      page: 1,
      per_page: 30
    ]

    {photos, metadata} =
      case unsplash_client.search_photo(search) do
        {:ok, {photos, metadata}} -> {photos, metadata}
        _ -> {[], %{}}
      end

    metadata =
      metadata
      |> Map.put_new("query", value)
      |> Map.put_new("page", 1)

    socket =
      socket
      |> assign(update_action: "replace")
      |> assign(query: value)
      |> assign(photos: photos)
      |> push_event("fetch_result", %{"photos" => photos, "metadata" => metadata})

    {:noreply, socket}
  end

  def handle_event("next_page", %{"query" => query, "page" => page} = params, socket) do
    unsplash_client = LiveViewExampleUsage.unsplash_client()

    query_params = [
      query: query,
      page: page,
      per_page: 30
    ]

    {photos, metadata} =
      case unsplash_client.search_photo(query_params) do
        {:ok, {photos, metadata}} -> {photos, metadata}
        _ -> {[], %{}}
      end

    metadata =
      metadata
      |> Map.put_new("query", query)
      |> Map.put_new("page", page)

    socket =
      socket
      |> assign(update_action: "append")
      |> assign(query: query)
      |> assign(photos: photos)
      |> push_event("fetch_result", %{"photos" => photos, "metadata" => metadata})

    {:noreply, socket}
  end
end
