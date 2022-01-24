defmodule OsBlogWeb.Resolvers.ManagerResolver do
  alias OsBlog.Managers
  alias Argon2

  def get_manager(_parent, _args, _resolution) do
    Managers.get_manager()
  end

  def update_manager(_parent, %{manager: args}, _resolution), do: Managers.update_manager(args)

  def login(_parent, args, _resolution) do
    manager = Managers.get_manager_by(email: String.downcase(args[:email]))

    if manager && Argon2.verify_pass(args[:password], manager.password) do
      {:ok, token, _} = OsBlog.Guardian.encode_and_sign(manager)
      {:ok, %{token: token}}
    else
      Argon2.no_user_verify()
      {:error, :unauthenticated}
    end
  end
end
