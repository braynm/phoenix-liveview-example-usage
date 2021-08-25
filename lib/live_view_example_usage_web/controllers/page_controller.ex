defmodule LiveViewExampleUsageWeb.PageController do
  use LiveViewExampleUsageWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def pagination(conn, _params) do
    conn
    |> put_layout(false)
    |> render("pagination.html")
  end
end
