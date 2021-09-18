defmodule LiveViewExampleUsageWeb.ChatController do
  use LiveViewExampleUsageWeb, :controller

  def login(conn, params) do
    users = LiveViewExampleUsage.Chat.user_list()

    conn
    |> render("login.html", users: users)
  end

  def login_session(conn, params) do
    conn
    |> put_session(:user, params["user"])
    |> redirect(to: "/chat")
  end

  def logout(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: "/chat/login")
  end
end
