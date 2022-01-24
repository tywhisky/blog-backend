defmodule OsBlogWeb.Schema do
  use Absinthe.Schema

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
  end

  mutation do
    import_fields(:manager_mutations)
    import_fields(:article_mutations)
  end
end
