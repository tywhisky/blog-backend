defmodule OsBlogWeb.ResolverHelpers do
  def render_payload(%Scrivener.Page{} = result) do
    {entries, page_info} = Map.pop(result, :entries)
    {:ok, %{entries: entries, page_info: page_info}}
  end

  def render_payload(_), do: {:error, :not_found}

  def current_user(%{context: %{current_user: %{"manager" => manager}}}), do: manager

  def current_user(_resolution), do: nil
end
