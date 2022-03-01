defmodule OsBlogWeb.Router do
  use OsBlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql_auth do
    plug CORSPlug
    plug OsBlogWeb.Plugs.PutContextForGraphql
  end

  pipeline :browser_auth do
    plug Guardian.Plug.Pipeline, module: OsBlog.Guardian, error_handler: OsBlog.Guardian
    plug Guardian.Plug.VerifyHeader, refresh_from_cookie: [exchange_from: "access"]
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api" do
    pipe_through :graphql_auth

    forward "/graphql", Absinthe.Plug, schema: OsBlogWeb.Schema
  end

  scope "/api" do
    pipe_through [:browser, :browser_auth]

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: OsBlogWeb.Schema
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
end
