defmodule OsBlogWeb.Resolvers.ArticleResolver do
  alias OsBlog.Articles

  def create_article(_parent, %{article: args}, _resolution) do
    Articles.create_article(args)
  end
end
