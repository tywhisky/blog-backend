defmodule OsBlogWeb.Schema.CategoryTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.CategoryResolver

  object :category, description: "文章分类" do
    field :id, :id, description: "ID"
    field :name, :string, description: "分类名称"
  end

  payload_paginate(:categories_payload, :category)

  input_object :category_input do
    field :name, non_null(:string), description: "文章分类"
  end

  object :category_queries do
    field :categories, :categories_payload, description: "分类列表" do
      arg :page_params, :page_params, description: "页码信息"
      arg :name, :string, description: "分类信息"

      resolve &CategoryResolver.list_categories/3
    end
  end

  object :category_mutations do
    field :create_category, type: :category, description: "新建分类" do
      arg :category, non_null(:category_input), description: "分类信息"

      resolve &CategoryResolver.create_category/3
    end

    field :update_category, type: :category, description: "更新分类" do
      arg :id, non_null(:id), description: "分类ID"
      arg :category, non_null(:category_input), description: "分类信息"

      resolve &CategoryResolver.update_category/3
    end

    field :delete_category, type: :category, description: "删除分类" do
      arg :id, non_null(:id), description: "分类ID"

      resolve &CategoryResolver.delete_category/3
    end
  end
end
