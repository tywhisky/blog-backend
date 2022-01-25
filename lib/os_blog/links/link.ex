defmodule OsBlog.Links.Link do
  use OsBlog, :schema

  schema "links" do
    field :url, :string
    field :title, :string
    field :description, :string
    field :order, :integer

    timestamps()
  end

  def create_changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :title, :description, :order])
    |> validate_required([:url])
  end

  def update_changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :title, :description, :order])
  end

  def delete_changeset(category) do
    category
    |> change()
    |> no_assoc_constraint(:articles)
  end
end
