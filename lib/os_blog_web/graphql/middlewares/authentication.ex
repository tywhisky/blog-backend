defmodule OsBlogWeb.Middlewares.Authentication do
  @behaviour Absinthe.Middleware

  def call(resolution, _config) do
    case OsBlogWeb.ResolverHelpers.current_user(resolution) do
      nil -> Absinthe.Resolution.put_result(resolution, {:error, :access_denied})
      _ -> resolution
    end
  end
end
