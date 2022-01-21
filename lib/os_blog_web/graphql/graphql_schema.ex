defmodule OsBlogWeb.Schema do
  use Absinthe.Schema

  alias OsBlogWeb.Schema.{
    ManagerTypes
  }

  import_types(ManagerTypes)

  query do
    import_fields(:manager_queries)
  end

  mutation do
    import_fields(:manager_mutations)
  end
end
