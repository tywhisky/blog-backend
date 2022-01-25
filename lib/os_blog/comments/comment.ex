defmodule OsBlog.Comments.Comment do
  use OsBlog, :schema

  alias OsBlog.CommentStatusEnum
  alias OsBlog.Articles.Article

  @type t :: %__MODULE__{}

  schema "comments" do
    field :body, :string
    field :creator, :string
    field :creator_email, :string
    field :reply, :string
    field :status, Ecto.Enum, values: CommentStatusEnum.values(), default: :checking

    belongs_to :article, Article

    timestamps()
  end

  def create_changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :creator, :creator_email])
    |> validate_required([:body, :creator, :creator_email])
  end

  def update_changeset(comment, attrs) do
    comment
    |> cast(attrs, [:reply, :status])
  end

  def delete_changeset(comment) do
    comment
    |> change()
    |> no_assoc_constraint(:articles)
  end
end
