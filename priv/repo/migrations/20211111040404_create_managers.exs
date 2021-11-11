defmodule OsBlog.Repo.Migrations.CreateManagers do
  use Ecto.Migration

  def change do
    create table(:managers) do
      add :name, :string
      add :email, :string
      add :password_digest, :string
      add :avatar, :string

      timestamps()
    end

    create unique_index(:managers, [:email], name: :managers_uniq_email_index)
  end
end
