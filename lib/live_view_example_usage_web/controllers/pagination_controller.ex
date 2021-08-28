defmodule LiveViewExampleUsageWeb.PaginationController do
  use LiveViewExampleUsageWeb, :controller

  def index(conn, _params) do
    page_id = Ecto.UUID.generate()

    conn
    |> put_layout(false)
    |> render("index.html", page_id: page_id)
  end
end
