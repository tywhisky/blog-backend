defmodule OsBlog.Articles.Comment do
  use OsBlog, :schema

  alias OsBlog.Articles.Article

  @type t :: %__MODULE__{}

  defenum(CommentStatusEnum, ["approved", "pending", "reject"])

  schema "comments" do
    field :title, :string
    field :body, :string
    field :author, :string
    field :email, :string
    field :status, CommentStatusEnum
    belongs_to :article, Article, on_replace: :nilify
    timestamps(type: :utc_datetime_usec)
  end
end
