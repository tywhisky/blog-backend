defmodule OsBlogWeb.ViewPaginationHelpers do
  @doc """
  渲染分页数据，提供统一的 payload

  ## 例子

      # 原样输出 items
      render_page(page, & &1)

      # 对 items 的做转换
      render_page(page, &survey_json(&1, extra_things))

  渲染结果

      %{
        items: [...],
        page_info: %{...}
      }

  `page_info` 具体看 `page_info/2` 函数
  """
  def render_page(page, item_mapper) do
    %{
      items: Enum.map(page.entries, item_mapper),
      page_info: page_info(page)
    }
  end

  @doc """
  同 `render_page/2` ，添加了 `meta` 参数，它必须是 map
  """
  def render_page(page, item_mapper, meta) do
    page
    |> render_page(item_mapper)
    |> Map.put(:meta, meta)
  end

  defp page_info(%Scrivener.Page{} = page) do
    %{
      type: "page",
      current: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_count: page.total_entries
    }
  end
end
