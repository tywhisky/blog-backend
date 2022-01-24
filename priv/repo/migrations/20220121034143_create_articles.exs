defmodule OsBlog.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :cover, :string
      add :clicks, :integer
      add :status, :string
      add :body, :string
      add :category_id, references(:categories)

      timestamps()
    end

    create unique_index(:articles, [:title], name: :articles_uniq_title_index)
  end
end
