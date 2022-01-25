defmodule OsBlog.EctoHelpers do
  import Ecto.Query

  @spec filter_by(
          query :: Ecto.Queryable.t(),
          field :: atom(),
          value :: term() | {atom(), term()},
          opts :: keyword()
        ) ::
          Ecto.Queryable.t()

  def filter_by(query, field, value, opts \\ [op: :and])

  def filter_by(query, _, nil, _), do: query
  def filter_by(query, _, {_, nil}, _), do: query

  def filter_by(query, _, {type, ""}, _) when type in [:has_prefix, :has_suffix, :contains],
    do: query

  def filter_by(query, field, value, opts) do
    op = Keyword.get(opts, :op, :and)
    do_filter_by(op, query, field, value)
  end

  defp do_filter_by(:and, query, field, {:has_prefix, value}),
    do: where(query, [q], ilike(field(q, ^field), ^"#{value}%"))

  defp do_filter_by(:and, query, field, {:has_suffix, value}),
    do: where(query, [q], ilike(field(q, ^field), ^"%#{value}"))

  defp do_filter_by(:and, query, field, {:contains, value}),
    do: where(query, [q], ilike(field(q, ^field), ^"%#{value}%"))

  defp do_filter_by(:and, query, field, value) when is_list(value),
    do: where(query, [q], field(q, ^field) in ^value)

  defp do_filter_by(:and, query, field, {:lte, value}),
    do: where(query, [q], field(q, ^field) <= ^value)

  defp do_filter_by(:and, query, field, {:gte, value}),
    do: where(query, [q], field(q, ^field) >= ^value)

  defp do_filter_by(:and, query, field, value),
    do: where(query, [q], field(q, ^field) == ^value)

  defp do_filter_by(:or, %Ecto.Query{} = query, field, value) do
    other_query =
      Ecto.Query
      |> struct(Map.take(query, [:from, :select]))
      |> filter_by(field, value)

    union(query, ^other_query)
  end

  defp do_filter_by(:or, query, field, value),
    do: do_filter_by(:and, query, field, value)
end
