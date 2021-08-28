defmodule LiveViewExampleUsageWeb.LiveSearch do
  use Phoenix.LiveView

  def mount(params, %{"page_id" => page_id}, socket) do
    IO.inspect("LIVE SEARCH #{inspect(socket.root_pid)}")

    if connected?(socket) do
      Phoenix.PubSub.subscribe(LiveViewExampleUsage.PubSub, "page_#{page_id}")
      # Phoenix.PubSub.subscribe(LiveViewExampleUsage.PubSub, "page_#{page_id}")
    end

    socket =
      socket
      |> assign("page_id", page_id)

    {:ok, socket, temporary_assigns: [photos: []]}
  end

  def handle_event("search", query_param, socket) do
    Phoenix.PubSub.broadcast_from!(
      LiveViewExampleUsage.PubSub,
      self(),
      "page_#{socket.assigns["page_id"]}",
      {:search_from_input, query_param}
    )

    {:noreply, socket}
  end

  def handle_event("next", query_param, socket) do
    Phoenix.PubSub.broadcast_from!(
      LiveViewExampleUsage.PubSub,
      self(),
      "page_#{socket.assigns["page_id"]}",
      {:next, query_param}
    )

    {:noreply, socket}
  end

  def handle_info(page_id, socket) do
    {:noreply, socket}
  end
end
