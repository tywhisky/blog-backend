defmodule OsBlogWeb.Resolvers.LinkResolver do
  use OsBlogWeb, :resolver

  alias OsBlog.Links

  def create_link(_parent, %{link: args}, _resolution) do
    Links.create_link(args)
  end

  def list_links(_parent, args, _) do
    Links.list_links(args) |> render_payload()
  end

  def update_link(_parent, %{id: id, link: args}, _) do
    Links.get_link(id)
    |> Links.update_link(args)
  end

  def delete_link(_parent, %{id: id}, _) do
    Links.get_link(id)
    |> Links.delete_link()
  end
end
