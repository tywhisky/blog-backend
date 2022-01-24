defmodule OsBlog.Articles.Category do
  use OsBlog, :schema

  alias OsBlog.Articles.Article

  schema "categories" do
    field :name, :string

    timestamps()

    has_many :articles, Article, foreign_key: :article_id
  end
end
