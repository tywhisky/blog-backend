defmodule OsBlogWeb.CommentController do
  use OsBlogWeb, :controller

  alias OsBlog.Articles.{Comment, Comments}

  action_fallback OsBlogWeb.FallbackController

  def index(conn, params) do
    page = Comments.list_comments(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, params) do
    with {:ok, comment} <- Comments.create(params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id} = params) do
    comment = Comments.get_comment!(id)

    with {:ok, comment} <- Comments.update_comment(comment, params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)

    with {:ok, %Comment{}} <- Comments.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
