defmodule LiveViewExampleUsageWeb.SearchLive.Index do
  use Phoenix.LiveView

  def mount(_params, %{"page_id" => page_id}, socket) do
    socket =
      socket
      |> assign(:page_id, page_id)

    {:ok, socket}
  end
end
