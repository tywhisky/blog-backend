defmodule OsBlogWeb.TagController do
  use OsBlogWeb, :controller

  alias OsBlog.Tags
  alias OsBlog.Tags.Tag

  action_fallback OsBlogWeb.FallbackController

  def index(conn, params) do
    page = Tags.list_tags(params)
    render(conn, "index.json", page: page)
  end

  def create(conn, params) do
    with {:ok, tag} <- Tags.create(params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id} = params) do
    tag = Tags.get_tag!(id)

    with {:ok, tag} <- Tags.update_tag(tag, params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{}} <- Tags.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
