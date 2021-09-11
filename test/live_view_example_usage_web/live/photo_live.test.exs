defmodule LiveViewExampleUsageWeb.PhotoLiveTest do
  use LiveViewExampleUsageWeb.ConnCase
  import Phoenix.LiveViewTest
  import Mox

  setup :verify_on_exit!

  @session %{"page_id" => "sample_page_id"}

  test "connected mount", %{conn: conn} do
    query = "labrador"

    {:ok, view, _html} =
      live_isolated(conn, LiveViewExampleUsageWeb.PhotoLive.Index, session: @session)

    assert has_element?(view, form_id(""))
  end

  test "search labrador dogs", %{conn: conn} do
    query = "labrador"

    {:ok, view, _html} =
      live_isolated(conn, LiveViewExampleUsageWeb.PhotoLive.Index, session: @session)

    assert has_element?(view, "#photos")
    refute has_element?(view, first_photo_item("id1"))
    refute has_element?(view, form_id(query))

    mock_unsplash_api()
    search_keyword(view, query)

    assert has_element?(view, "#photos#{query}")
    assert has_element?(view, "#img-id1")
  end

  def search_keyword(view, query) do
    view
    |> element("#photos")
    |> render_hook(:search, %{value: query})

    view
  end

  test "request next page", %{conn: conn} do
    query = "labrador"
    page = %{query: query, page: 2}

    {:ok, view, _html} =
      live_isolated(conn, LiveViewExampleUsageWeb.PhotoLive.Index, session: @session)

    assert has_element?(view, "#photos")
    refute has_element?(view, "#id2")
    refute has_element?(view, form_id(query))

    mock_unsplash_api()

    request_next_page(view, page)

    assert has_element?(view, "#photos#{query}")
    assert has_element?(view, "#img-id2")
  end

  def search_keyword(view, query) do
    view
    |> element("#photos")
    |> render_hook(:search, %{value: query})

    view
  end

  defp request_next_page(view, params) do
    view
    |> element("#photos")
    |> render_hook(:next_page, params)

    view
  end

  defp first_photo_item(id), do: photo_item(id)
  defp form_id(query), do: "#photos#{query}"
  defp photo_item(id), do: "#item-#{id}"

  defp mock_unsplash_api() do
    LiveViewExampleUsage.UnsplashMock
    |> expect(:search_photo, fn params ->
      case params[:page] do
        1 -> result(params)
        2 -> result(query: params[:query], page: 2)
      end
    end)
  end

  defp result(query: query, page: page) do
    metadata = %{total_pages: 2, page: page}

    photos = [
      %{
        blur_hash: "LVN,Vt.Tn$NIt.t8azay-oVrIUxu",
        description: nil,
        height: 500,
        id:
          case page do
            1 -> "id1"
            2 -> "id2"
            _ -> "unknown"
          end,
        url: "https://images.unsplash.com/photo-123",
        width: 500
      }
    ]

    {:ok, {photos, metadata}}
  end
end
