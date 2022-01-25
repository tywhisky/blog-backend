defmodule OsBlogWeb.Resolvers.CategoryResolver do
  use OsBlogWeb, :resolver

  alias OsBlog.Articles.Categories

  def create_category(_parent, %{category: args}, _resolution) do
    Categories.create_category(args)
  end

  def list_categories(_parent, args, _) do
    Categories.list_categories(args) |> render_payload()
  end
end
