defmodule OsBlogWeb.Schema.CategoryTypes do
  use OsBlogWeb, :schema

  object :category, description: "文章分类" do
    field :id, :id, description: "ID"
    field :name, :string, description: "分类名称"
  end
end
