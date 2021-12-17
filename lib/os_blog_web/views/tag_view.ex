defmodule OsBlogWeb.TagView do
  use OsBlogWeb, :view
  alias OsBlogWeb.TagView
  alias OsBlogWeb.ViewPaginationHelpers

  def render("index.json", %{page: page}) do
    ViewPaginationHelpers.render_page(page, &tag_json/1)
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{
      id: tag.id,
      name: tag.name
    }
  end

  def tag_json(tag) do
    tag
    |> Map.take([
      :id,
      :name
    ])
  end
end
