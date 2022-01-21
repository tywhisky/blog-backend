defmodule OsBlog.Managers.Manager do
  use Ecto.Schema
  import Ecto.Changeset

  schema "managers" do
    field :name, :string
    field :email, :string
    field :password_digest, :string
    field :avatar, :string

    timestamps()
  end

  def update_changeset(manager, attrs) do
    manager
    |> cast(attrs, [:name, :email, :password_digest, :avatar])
  end
end
