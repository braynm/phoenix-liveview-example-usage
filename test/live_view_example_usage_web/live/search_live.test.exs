defmodule LiveViewExampleUsageWeb.SearchLiveTest do
  use LiveViewExampleUsageWeb.ConnCase
  import Phoenix.LiveViewTest

  test "connected mount", %{conn: conn} do
    session = %{"page_id" => "sample_page_id"}

    # Mounted
    {:ok, view, _html} =
      live_isolated(conn, LiveViewExampleUsageWeb.SearchLive.Index, session: session)

    assert has_element?(view, "form[data-page-id='sample_page_id']")
  end
end
