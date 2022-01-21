defmodule OsBlog.Repo.Migrations.CreateSystemInfo do
  use Ecto.Migration

  def change do
    create table(:system_info) do
      add :site_name, :string
      add :site_desc, :string
      add :site_logo, :string
      add :favicon, :string
      add :foot_about, :string
      add :foot_filing, :string
      add :foot_copy_right, :string
      add :foot_powered_by, :string
      add :foot_powered_by_url, :string

      timestamps()
    end
  end
end
