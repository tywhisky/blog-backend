defmodule OsBlogWeb.CommentController do
  use OsBlogWeb, :controller

  alias OsBlog.Articles.Comments

  action_fallback OsBlogWeb.FallbackController

#  def index(conn, params) do
#    page = Articles.list_articles(params)
#    render(conn, "index.json", page: page)
#  end
#
  def create(conn, params) do
    with {:ok, comment} <- Comments.create(params) do
      render(conn, "show.json", comment: comment)
    end
  end
#
#  def show(conn, %{"id" => id}) do
#    article = Articles.get_article!(id)
#    render(conn, "show.json", article: article)
#  end
#
#  def update(conn, %{"id" => id} = params) do
#    article = Articles.get_article!(id)
#
#    with {:ok, %Article{} = article} <- Articles.update_article(article, params) do
#      render(conn, "show.json", article: article)
#    end
#  end
#
#  def delete(conn, %{"id" => id}) do
#    article = Articles.get_article!(id)
#
#    with {:ok, %Article{}} <- Articles.delete_article(article) do
#      send_resp(conn, :no_content, "")
#    end
#  end
end
