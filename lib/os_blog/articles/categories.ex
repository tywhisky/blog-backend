defmodule OsBlog.Articles.Categories do
  use OsBlog, :context

  alias OsBlog.Articles.Category

  def create_category(attrs) do
    %Category{}
    |> Category.create_changeset(attrs)
    |> Repo.insert()
  end
end
