defmodule LiveViewExampleUsageWeb.Router do
  use LiveViewExampleUsageWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveViewExampleUsageWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/pagination", PaginationController, :index
    get "/chat/login", ChatController, :login
    get "/chat/login_session", ChatController, :login_session
    get "/chat/logout", ChatController, :logout

    live "/chat", ChatLive, layout: {LiveViewExampleUsageWeb.LayoutView, "app.html"}
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveViewExampleUsageWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: LiveViewExampleUsageWeb.Telemetry
    end
  end
end
