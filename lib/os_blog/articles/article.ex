defmodule OsBlog.Articles.Article do
  use OsBlog, :schema

  alias OsBlog.Articles.Category
  alias OsBlog.Comments.Comment
  alias OsBlog.ArticleStatusEnum

  @type t :: %__MODULE__{}

  schema "articles" do
    field :title, :string
    field :body, :string
    field :cover, :string
    field :clicks, :integer
    field :status, Ecto.Enum, values: ArticleStatusEnum.values(), default: :pending

    belongs_to :category, Category

    has_many :comment, Comment, on_delete: :delete_all

    timestamps()
  end

  def create_changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :cover, :body, :category_id])
    |> validate_required([:title])
  end

  def update_changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :body, :cover, :clicks, :status, :category_id])
  end
end
