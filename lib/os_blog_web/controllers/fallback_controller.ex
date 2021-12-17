defmodule OsBlogWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use OsBlogWeb, :controller

  alias OsBlogWeb.ChangesetView

  def call(conn, {:error, %Ecto.Changeset{} = chset}) do
    validation_error(conn, chset)
  end

  def call(conn, {:error, :cast_error}) do
    render_error(conn, 400, code: :bad_request)
  end

  def call(conn, {:error, :unauthenticated}) do
    render_error(conn, 401, code: :unauthenticated)
  end

  # handle bodyguard authorization failure
  def call(conn, {:error, :unauthorized}) do
    render_error(conn, 403, code: :unauthorized)
  end

  def call(conn, {:error, :not_found}) do
    render_error(conn, 404, code: :not_found)
  end

  def call(conn, {:error, :stale_entry_error}) do
    render_error(conn, 409, code: :stale_entry_error)
  end

  def call(conn, {:error, code}) do
    render_error(conn, 422, code: code)
  end

  # Guardian.Plug.EnsureAuthenticated 验证失败回调
  def auth_error(conn, _, _) do
    if String.contains?(conn.request_path, "download") do
      redirect(conn, external: "/login")
    else
      render_error(conn, 401, code: :unauthenticated)
    end
  end

  defp render_error(conn, status, assigns) do
    OsBlog.ErrorCode.validate_code!(Keyword.fetch!(assigns, :code))

    conn
    |> put_status(status)
    |> put_view(OsBlogWeb.ErrorView)
    |> render("#{status}.json", assigns)
  end

  defp validation_error(conn, chset) do
    errors = ChangesetView.translate_errors(chset)
    render_error(conn, 422, code: :validation_error, errors: errors)
  end
end
