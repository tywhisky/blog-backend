defmodule OsBlogWeb.Plugs.PutContextForGraphql do
  @behaviour Plug

  import Plug.Conn
  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, manager} <- authorize(token) do
      %{current_user: manager}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    case OsBlog.Guardian.resource_from_token(token) do
      {:ok, manager, _} -> {:ok, manager}
      {:error, _} -> {:error, :invalid_token}
    end
  end
end
