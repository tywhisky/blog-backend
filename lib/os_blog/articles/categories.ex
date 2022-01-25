defmodule OsBlog.Articles.Categories do
  use OsBlog, :context

  alias OsBlog.Articles.Category

  import OsBlog.EctoHelpers, only: [filter_by: 3]

  def get_category(id), do: Repo.get(Category, id)

  def create_category(attrs) do
    %Category{}
    |> Category.create_changeset(attrs)
    |> Repo.insert()
  end

  def list_categories(params \\ %{}) do
    Category
    |> filter_by(:inserted_at, {:gte, params[:inserted_at][:start]})
    |> filter_by(:inserted_at, {:lte, params[:inserted_at][:end]})
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(params[:page_params])
  end

  def update_category(category, attrs) do
    category
    |> Category.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_category(category) do
    category
    |> Category.delete_changeset()
    |> Repo.delete()
  end
end
