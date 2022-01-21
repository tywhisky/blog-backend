defmodule OsBlog.Repo.Migrations.CreateManagers do
  use Ecto.Migration

  def change do
    create table(:managers) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :avatar, :string

      timestamps()
    end
  end
end
