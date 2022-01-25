defmodule OsBlogWeb.Resolvers.CategoryResolver do
  alias OsBlog.Articles.Categories

  def create_category(_parent, %{category: args}, _resolution) do
    Categories.create_category(args)
  end
end
