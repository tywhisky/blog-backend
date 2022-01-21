defmodule OsBlog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :creator, :string
      add :creator_email, :string
      add :status, :string
      add :reply, :string
      add :article_id, references(:articles)

      timestamps()
    end
  end
end
