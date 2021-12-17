defmodule OsBlog.TagsArticles.TagsArticle do
  use OsBlog, :schema

  alias OsBlog.Articles.Article
  alias OsBlog.Tags.Tag

  @type t :: %__MODULE__{}

  schema "tags" do
    belongs_to :article, Article
    belongs_to :tag, Tag

    timestamps(type: :utc_datetime_usec)
  end

  def changeset(tag_article, attrs) do
    tag_article
    |> cast(attrs, [:article_id, :tag_id])
    |> validate_required([:article_id, :tag_id])
  end
end