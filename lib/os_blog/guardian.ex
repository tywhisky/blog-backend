defmodule OsBlog.Guardian do
  use Guardian, otp_app: :os_blog

  alias OsBlog.Accounts
  alias OsBlog.Accounts.Manager

  def subject_for_token(%Manager{id: id}, _claims) do
    {:ok, Jason.encode!(%{"manager" => %{"id" => id}})}
  end

  def subject_for_token(%{manager: %{id: id}, meta: meta}, _claims) do
    {:ok, Jason.encode!(%{"manager" => %{"id" => id}, meta: meta})}
  end

  def subject_for_token(_, _), do: {:error, :not_found}

  def resource_from_claims(%{"sub" => sub}) do
    with {:ok, %{"manager" => %{"id" => id}} = sub} <- Jason.decode(sub),
         {:ok, manager} <- get_manager(id) do
      {:ok, Map.put(sub, "manager", manager)}
    else
      result -> result
    end
  end

  def get_manager(id) do
    case Accounts.get_manager(id) do
      %Manager{} = manager -> {:ok, manager}
      _ -> {:error, :not_found}
    end
  end

  # Guardian pipeline error_handler
  def auth_error(conn, _, _) do
    request_path = URI.encode_www_form(conn.request_path)
    Phoenix.Controller.redirect(conn, to: "/login?redirect-to=#{request_path}")
  end
end
