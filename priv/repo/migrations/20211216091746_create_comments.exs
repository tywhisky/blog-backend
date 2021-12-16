defmodule OsBlog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table("comments") do
      add :article_id, references(:articles, on_delete: :delete_all)
      add :title, :string
      add :body, :text
      add :author, :string
      add :email, :string
      add :status, :string

      timestamps()
    end
  end
end
