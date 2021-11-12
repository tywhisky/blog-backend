defmodule OsBlog.ArticlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OsBlog.Articles` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        author: "some author",
        content: "some content",
        title: "some title"
      })
      |> OsBlog.Articles.create_article()

    article
  end
end
