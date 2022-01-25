defmodule OsBlog.Articles do
  use OsBlog, :context

  alias OsBlog.Articles.Article

  import OsBlog.EctoHelpers, only: [filter_by: 3]

  def create_article(attrs) do
    %Article{}
    |> Article.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_article(article, attr) do
    article
    |> Article.update_changeset(attr)
    |> Repo.update()
  end

  def get_article!(id), do: Repo.get!(Article, id)

  def list_articles(params \\ %{}) do
    Article
    |> filter_by(:inserted_at, {:gte, params[:inserted_at][:start]})
    |> filter_by(:inserted_at, {:lte, params[:inserted_at][:end]})
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(params[:page_params])
  end

  def delete_article(id) do
    get_article!(id)
    |> Repo.delete()
  end
end
