defmodule OsBlogWeb.Plugs.VerifyMeta do
  def init(opts), do: opts

  def call(conn, opts) do
    case OsBlog.Guardian.Plug.current_resource(conn) do
      %{"meta" => meta} -> meta |> verify(conn) |> respond(conn, opts)
      _ -> conn
    end
  end

  defp verify(params, conn) do
    params
    |> Enum.reduce_while(:ok, fn {key, value}, acc ->
      case do_verify(key, value, conn) do
        :ok -> {:cont, acc}
        result -> {:halt, result}
      end
    end)
  end

  def do_verify("allow_requests", requests, %{method: method, request_path: path}) do
    if Enum.any?(requests, &(&1 == "#{method}:#{path}")),
      do: :ok,
      else: {:error, :not_allow_request}
  end

  def do_verify(_, _, _) do
    {:error, :invalid_meta}
  end

  defp respond(:ok, conn, _), do: conn

  defp respond({:error, reason}, conn, opts) do
    conn
    |> Guardian.Plug.Pipeline.fetch_error_handler!(opts)
    |> apply(:auth_error, [conn, {:unauthenticated, reason}, opts])
    |> Plug.Conn.halt()
  end
end
