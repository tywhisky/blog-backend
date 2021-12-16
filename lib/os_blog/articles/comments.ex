defmodule OsBlog.Articles.Comments do
  use OsBlog, :context

  alias OsBlog.Articles.Comment

  def create(params) do
    %Comment{}
    |> cast(params, [:title, :body, :author, :article_id, :status])
    |> validate_required([:article_id])
    |> Repo.insert()
  end
end