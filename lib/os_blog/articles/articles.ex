defmodule OsBlog.Articles do
  use OsBlog, :context

  alias OsBlog.Articles.Article

  def create_article(attrs) do
    %Article{}
    |> Article.create_changeset(attrs)
    |> Repo.insert()
  end
end
