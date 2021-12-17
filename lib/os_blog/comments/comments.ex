defmodule OsBlog.Articles.Comments do
  use OsBlog, :context

  alias OsBlog.Articles.Comment

  def create(attrs) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  def list_comments(params) do
    Comment
    |> Repo.paginate(params)
  end

  def get_comment!(id), do: Repo.get!(Comment, id)

  def update_comment(%Comment{} = comment, attrs) do
    comment
    |> Comment.changeset(attrs)
    |> Repo.update()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end
end
