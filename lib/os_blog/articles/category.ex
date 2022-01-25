defmodule OsBlog.Articles.Category do
  use OsBlog, :schema

  alias OsBlog.Articles.Article

  schema "categories" do
    field :name, :string

    timestamps()

    has_many :articles, Article, foreign_key: :article_id
  end

  def create_changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def update_changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
  end

  def delete_changeset(category) do
    category
    |> change()
    |> no_assoc_constraint(:articles)
  end
end
