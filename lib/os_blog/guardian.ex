defmodule OsBlog.Guardian do
  import Plug.Conn

  use Guardian, otp_app: :os_blog

  alias OsBlog.Managers
  alias OsBlog.Managers.Manager

  def subject_for_token(%{id: id}, _claims) do
    {:ok, Jason.encode!(%{"manager" => %{"id" => id}})}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => sub}) do
    with {:ok, sub} <- Jason.decode(sub),
         {:ok, manager} <- get_manager() do
      {:ok, Map.put(sub, "manager", manager)}
    else
      result -> result
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def get_manager() do
    case Managers.get_manager() do
      {:ok, manager} -> {:ok, manager}
      _ -> {:error, :not_found}
    end
  end

  # Guardian pipeline error_handler
  def auth_error(conn, {type, _reason}, _opts) do
    body = to_string(type)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(401, body)
  end
end
