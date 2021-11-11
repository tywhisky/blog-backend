defmodule OsBlog.Accounts.Manager do
  use Ecto.Schema
  import Ecto.Changeset

  schema "managers" do
    field :avatar, :string
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :old_password, :string, virtual: true
    field :password_digest, :string

    timestamps()
  end

  @doc false
  def changeset(manager, attrs) do
    manager
    |> cast(attrs, [:name, :email, :password_digest, :avatar])
    |> validate_required([:name, :email, :password_digest, :avatar])
  end

  def create_changeset(manager, attrs) do
    password = attrs[:password] || attrs["password"]

    manager
    |> cast(attrs, [:name, :email, :password, :avatar])
    |> validate_required([:email, :password])
    |> put_change(:password_digest, password && Bcrypt.hash_pwd_salt(password))
    |> validate_length(:password, min: 6)
    |> validate_email()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email, name: :managers_uniq_email_index)
  end
end
