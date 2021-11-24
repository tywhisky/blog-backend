defmodule OsBlogWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use OsBlogWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(OsBlogWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(OsBlogWeb.ErrorView)
    |> render(:"404")
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
end
