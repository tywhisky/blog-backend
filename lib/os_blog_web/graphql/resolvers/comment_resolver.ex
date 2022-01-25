defmodule OsBlogWeb.Resolvers.CommentResolver do
  use OsBlogWeb, :resolver

  alias OsBlog.Comments

  def create_comment(_parent, %{comment: args}, _resolution) do
    Comments.create_comment(args)
  end

  def list_comments(_parent, args, _) do
    Comments.list_comments(args) |> render_payload()
  end

  def update_comment(_parent, %{id: id, comment: args}, _) do
    Comments.get_comment(id)
    |> Comments.update_comment(args)
  end

  def delete_comment(_parent, %{id: id}, _) do
    Comments.get_comment(id)
    |> Comments.delete_comment()
  end
end
