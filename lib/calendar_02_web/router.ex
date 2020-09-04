defmodule Calendar02Web.Router do
  use Calendar02Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {Calendar02Web.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Calendar02Web do
    pipe_through :browser

    live "/", PageLive, :index
    live "/calendars", CalendarLive, :index

    get "/reasons", ReasonController, :index
    get "/reasons/:id", ReasonController, :show
    delete "/reasons/:id", ReasonController, :delete
    get "/reasons/:date/:id/new", ReasonController, :new
    post "/reasons", ReasonController, :create
    get "/reasons/:id/edit", ReasonController, :edit
    patch "/reasons/:id", ReasonController, :update
    put "/reasons/:id", ReasonController, :update
    #resources "/reasons", ReasonController
    resources "/reasons_list", ReasonListController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Calendar02Web do
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
      live_dashboard "/dashboard", metrics: Calendar02Web.Telemetry
    end
  end
end
