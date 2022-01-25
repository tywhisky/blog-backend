defmodule OsBlog.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :title, :string
      add :description, :string
      add :order, :integer

      timestamps()
    end
  end
end
