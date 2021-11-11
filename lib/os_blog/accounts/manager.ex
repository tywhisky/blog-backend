defmodule OsBlog.Accounts.Manager do
  use Ecto.Schema
  import Ecto.Changeset

  schema "managers" do
    field :avatar, :string
    field :email, :string
    field :name, :string
    field :password_digest, :string

    timestamps()
  end

  @doc false
  def changeset(manager, attrs) do
    manager
    |> cast(attrs, [:name, :email, :password_digest, :avatar])
    |> validate_required([:name, :email, :password_digest, :avatar])
  end
end
