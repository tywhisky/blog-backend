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

  def create_changeset(manager, attrs) do
    manager
    |> cast(attrs, [:name, :email, :password, :avatar])
    |> validate_required([:email, :password])
    |> put_pass_hash()
    |> validate_length(:password, min: 6)
    |> validate_email()
  end

  def update_changeset(manager, attrs) do
    manager
    |> cast(attrs, [:name, :email, :password, :avatar])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password, hash_key: :password))
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email, name: :managers_uniq_email_index)
  end
end
