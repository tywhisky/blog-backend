defmodule OsBlogWeb.Router do
  use OsBlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug :accepts, ["json"]

    plug Guardian.Plug.Pipeline,
      module: OsBlog.Guardian,
      error_handler: OsBlogWeb.FallbackController

    plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated

    plug OsBlogWeb.Plugs.VerifyMeta
  end

  scope "/api", OsBlogWeb do
    pipe_through :api
    get "/login", ManagerController, :login

#    pipe_through :api_auth
    resources "/articles", ArticleController, except: [:new, :edit]
    resources "/managers", ManagerController, except: [:new, :edit]
  end

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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: OsBlogWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
