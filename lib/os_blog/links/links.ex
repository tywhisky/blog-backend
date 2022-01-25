defmodule OsBlog.Links do
  use OsBlog, :context

  alias OsBlog.Links.Link

  import OsBlog.EctoHelpers, only: [filter_by: 3]

  def create_link(attrs) do
    %Link{}
    |> Link.create_changeset(attrs)
    |> Repo.insert()
  end

  def list_links(params \\ %{}) do
    Link
    |> filter_by(:inserted_at, {:gte, params[:inserted_at][:start]})
    |> filter_by(:inserted_at, {:lte, params[:inserted_at][:end]})
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(params[:page_params])
  end

  def get_link(id), do: Repo.get(Link, id)

  def update_link(link, attrs) do
    link
    |> Link.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_link(link), do: Repo.delete(link)
end
