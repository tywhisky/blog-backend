defmodule OsBlog.Comments do
  use OsBlog, :context

  alias OsBlog.Comments.Comment

  import OsBlog.EctoHelpers, only: [filter_by: 3]

  def create_comment(attrs) do
    %Comment{}
    |> Comment.create_changeset(attrs)
    |> Repo.insert()
  end

  def list_comments(params \\ %{}) do
    Comment
    |> filter_by(:inserted_at, {:gte, params[:inserted_at][:start]})
    |> filter_by(:inserted_at, {:lte, params[:inserted_at][:end]})
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(params[:page_params])
  end

  def get_comment(id), do: Repo.get(Comment, id)

  def update_comment(comment, attrs) do
    comment
    |> Comment.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(comment), do: Repo.delete(comment)
end
