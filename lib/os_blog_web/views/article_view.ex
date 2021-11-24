defmodule OsBlogWeb.ArticleView do
  use OsBlogWeb, :view
  alias OsBlogWeb.ArticleView
  alias OsBlogWeb.ViewPaginationHelpers

  def render("index.json", %{page: page}) do
    ViewPaginationHelpers.render_page(page, &article_json/1)
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
      content: article.content,
      author: article.author
    }
  end

  def article_json(article) do
    article
    |> Map.take([
      :id,
      :author,
      :title,
      :content
    ])
  end
end
