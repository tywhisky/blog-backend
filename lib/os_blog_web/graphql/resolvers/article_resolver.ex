defmodule OsBlogWeb.Resolvers.ArticleResolver do
  use OsBlogWeb, :resolver

  alias OsBlog.Articles

  def create_article(_parent, %{article: args}, _resolution) do
    Articles.create_article(args)
  end

  def get_article(_parent, %{id: id}, _), do: {:ok, Articles.get_article!(id)}

  def list_articles(_parent, args, _) do
    Articles.list_articles(args) |> render_payload()
  end
end
