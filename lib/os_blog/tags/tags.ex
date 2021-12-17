defmodule OsBlog.Tags do
  use OsBlog, :context

  alias OsBlog.Tags.Tag

  def create(attrs) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  def list_tags(params) do
    Tag
    |> Repo.paginate(params)
  end

  def get_tag!(id), do: Repo.get!(Tag, id)

  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end
end