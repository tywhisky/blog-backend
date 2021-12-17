defmodule OsBlog.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias OsBlog.Repo

  alias OsBlog.Accounts.Manager

  def list_managers(params) do
    Manager
    |> Repo.paginate(params)
  end

  def get_manager(id), do: Repo.get(Manager, id)

  def get_manager!(id), do: Repo.get!(Manager, id)

  def create_manager(attrs \\ %{}) do
    %Manager{}
    |> Manager.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_manager(%Manager{} = manager, attrs) do
    manager
    |> Manager.changeset(attrs)
    |> Repo.update()
  end

  def delete_manager(%Manager{} = manager) do
    Repo.delete(manager)
  end

  def change_manager(%Manager{} = manager, attrs \\ %{}) do
    Manager.changeset(manager, attrs)
  end

  def get_manager_by(params), do: Repo.get_by(Manager, params)

  def create_session(attrs) do
    manager = get_manager_by(email: String.downcase(attrs["email"]))

    if manager && Bcrypt.verify_pass(attrs["password"], manager.password_digest) do
      {:ok, token, _} = OsBlog.Guardian.encode_and_sign(manager)
      {:ok, %{token: token}}
    else
      Bcrypt.no_user_verify()
      {:error, :unauthenticated}
    end
  end
end
