defmodule PersonalBlogWeb.PageController do
  use PersonalBlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
