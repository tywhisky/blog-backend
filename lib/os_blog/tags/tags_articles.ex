defmodule OsBlog.TagsArticles do
  use OsBlog, :context

  alias OsBlog.TagsArticles.TagsArticle

  def create(attrs) do
    %TagsArticle{}
    |> TagsArticle.changeset(attrs)
    |> Repo.insert()
  end

  def get_tag_article!(id), do: Repo.get!(TagsArticle, id)

  def delete_tag_article(%TagsArticle{} = tag_article) do
    Repo.delete(tag_article)
  end
end
