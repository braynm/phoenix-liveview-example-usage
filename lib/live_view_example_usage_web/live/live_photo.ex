defmodule LiveViewExampleUsageWeb.LivePhoto do
  use Phoenix.LiveView

  alias LiveViewExampleUsage.Unsplash.SearchPhoto
  alias LiveViewExampleUsage.Unsplash

  @default_update_action "replace"

  def mount(params, %{"page_id" => page_id}, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(LiveViewExampleUsage.PubSub, "page_#{page_id}")
    end

    socket =
      socket
      |> assign(fetching_photo: true)
      |> assign(query: nil)
      |> assign(update_action: @default_update_action)

    {:ok, socket, temporary_assigns: [photos: []]}
  end

  def handle_event("search", %{"value" => value}, socket) do
    search = %SearchPhoto{
      query: value,
      page: 1
    }

    {photos, metadata} =
      case Unsplash.search_photos(search) do
        {:ok, {photos, metadata}} -> {photos, metadata}
        _ -> {[], %{}}
      end

    metadata = Map.put_new(metadata, "query", value)

    IO.inspect(length(photos))

    socket =
      socket
      |> assign(update_action: "replace")
      |> assign(query: value)
      |> assign(photos: photos)
      |> push_event("fetch_result", %{"photos" => photos, "metadata" => metadata})

    {:noreply, socket}
  end

  def handle_info(:fetch_next_page, socket) do
    photos = Enum.to_list(21..40)

    socket =
      socket
      |> assign(fetching_photo: false)
      |> assign(photos: photos)
      |> assign(update_action: "append")

    {:noreply, socket}
  end

  def handle_info({:search_from_input, query_param} = data, socket) do
    send(self(), {:search_from_api, query_param})

    {:noreply, socket}
  end

  def handle_info({:next, query_param}, socket) do
    search = %LiveViewExampleUsage.Unsplash.SearchPhoto{
      query: query_param["search"],
      page: query_param["page"]
    }

    IO.inspect(query_param["page"], label: "PAGE")

    {photos, metadata} =
      case LiveViewExampleUsage.Unsplash.search_photos(search) do
        {:ok, {photos, metadata}} -> {photos, metadata}
        _ -> {[], %{}}
      end

    socket =
      socket
      |> assign(photos: photos)
      |> assign(update_action: "append")
      |> push_event("fetching_photo_done", %{"photos" => photos, "metadata" => metadata})

    {:noreply, socket}
  end

  def handle_info({:search_from_api, query_param}, socket) do
    search = %LiveViewExampleUsage.Unsplash.SearchPhoto{
      query: query_param,
      page: 1
    }

    {photos, metadata} =
      case LiveViewExampleUsage.Unsplash.search_photos(search) do
        {:ok, {photos, metadata}} -> {photos, metadata}
        _ -> {[], %{}}
      end

    socket =
      socket
      |> assign(update_action: "replace")
      |> assign(photos: photos)
      |> push_event("fetching_photo_done", %{"photos" => photos, "metadata" => metadata})

    {:noreply, socket}
  end
end
