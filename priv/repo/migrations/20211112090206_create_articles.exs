defmodule OsBlog.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :content, :text
      add :author, :string

      timestamps()
    end
  end
end
