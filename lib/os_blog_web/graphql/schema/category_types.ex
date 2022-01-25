defmodule OsBlogWeb.Schema.CategoryTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.CategoryResolver

  object :category, description: "文章分类" do
    field :id, :id, description: "ID"
    field :name, :string, description: "分类名称"
  end

  input_object :create_category_input do
    field :name, non_null(:string), description: "文章分类"
  end

  object :category_mutations do
    field :create_category, type: :category, description: "新建分类" do
      arg :category, non_null(:create_category_input), description: "分类信息"

      resolve &CategoryResolver.create_category/3
    end
  end
end
