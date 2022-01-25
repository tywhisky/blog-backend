defmodule OsBlogWeb.ResolverHelpers do
  def render_payload(%Scrivener.Page{} = result) do
    {entries, page_info} = Map.pop(result, :entries)
    {:ok, %{entries: entries, page_info: page_info}}
  end

  def render_payload(_), do: {:error, :not_found}
end
