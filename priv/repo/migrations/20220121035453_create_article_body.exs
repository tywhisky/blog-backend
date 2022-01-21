defmodule OsBlog.Repo.Migrations.CreateArticleBody do
  use Ecto.Migration

  def change do
    create table(:article_body) do
      add :body, :text
      add :article_id, references(:articles)

      timestamps()
    end
  end
end
