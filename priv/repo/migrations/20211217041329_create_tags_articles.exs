defmodule OsBlog.Repo.Migrations.CreateTagsArticles do
  use Ecto.Migration

  def change do
    create table("tags_articles") do
      add :tag_id, references(:tags)
      add :article_id, references(:articles)

      timestamps()
    end

    create unique_index(:tags_articles, [:tag_id, :article_id])
    create index(:tags_articles, [:article_id])
  end
end
