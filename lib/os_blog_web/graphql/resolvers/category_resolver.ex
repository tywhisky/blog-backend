defmodule OsBlogWeb.Resolvers.CategoryResolver do
  use OsBlogWeb, :resolver

  alias OsBlog.Articles.Categories

  def create_category(_parent, %{category: args}, _resolution) do
    Categories.create_category(args)
  end

  def list_categories(_parent, args, _) do
    Categories.list_categories(args) |> render_payload()
  end

  def update_category(_parent, %{id: id, category: args}, _) do
    Categories.get_category(id)
    |> Categories.update_category(args)
  end

  def delete_category(_parent, %{id: id}, _) do
    Categories.get_category(id)
    |> Categories.delete_category()
  end
end
