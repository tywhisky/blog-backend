defmodule OsBlogWeb.Schema do
  use Absinthe.Schema

  import Ecto.Query

  alias OsBlogWeb.Schema.{
    ManagerTypes,
    ArticleTypes,
    CategoryTypes
  }

  import_types(ManagerTypes)
  import_types(ArticleTypes)
  import_types(CategoryTypes)

  query do
    import_fields(:manager_queries)
    import_fields(:article_queries)
  end

  mutation do
    import_fields(:manager_mutations)
    import_fields(:article_mutations)
    import_fields(:category_mutations)
  end

  def context(ctx) do
    configs = [
      %{loader: OsBlogDataloader, repo: OsBlog.Repo, query: &dataloader_query/2}
    ]

    loader =
      Enum.reduce(configs, Dataloader.new(), fn
        %{repo: repo, query: query, loader: loader}, acc ->
          Dataloader.add_source(acc, loader, Dataloader.Ecto.new(repo, query: query))
      end)

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  # 如果有自定义 query 查询，请添加 Source 然后在相应的 Context 中处理
  defp dataloader_query(query, %{order_by: order_by} = params) do
    query
    |> order_by(^order_by)
    |> dataloader_query(Map.delete(params, :order_by))
  end

  defp dataloader_query(query, _params), do: query

  defp dataloader_fetcher({_field, args}, resources) do
    {fetcher, args} = Map.pop!(args, :fetcher)

    case Function.info(fetcher, :arity) do
      {_, 1} -> apply(fetcher, [resources])
      _ -> apply(fetcher, [resources, args])
    end
  end
end
