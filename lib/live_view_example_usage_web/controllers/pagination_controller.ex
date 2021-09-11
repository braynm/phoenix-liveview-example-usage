defmodule LiveViewExampleUsageWeb.PaginationController do
  use LiveViewExampleUsageWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html", page_id: Ecto.UUID.generate())
  end
end
