defmodule OsBlogWeb.CommentView do
  use OsBlogWeb, :view
  alias OsBlogWeb.CommentView
  alias OsBlogWeb.ViewPaginationHelpers

  def render("index.json", %{page: page}) do
    ViewPaginationHelpers.render_page(page, &comment_json/1)
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      title: comment.title,
      body: comment.body,
      author: comment.author,
      status: comment.status,
      email: comment.email,
      article_id: comment.article_id
    }
  end

  def comment_json(comment) do
    comment
    |> Map.take([
      :id,
      :author,
      :body,
      :email,
      :status,
      :article_id
    ])
  end
end
