defmodule OsBlog.Managers.Manager do
  use OsBlog, :schema

  import Argon2

  schema "managers" do
    field :name, :string
    field :email, :string
    field :password, :string
    field :avatar, :string

    timestamps()
  end

  def update_changeset(manager, attrs) do
    manager
    |> cast(attrs, [:name, :email, :password, :avatar])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password, hash_key: :password))
  end
end
