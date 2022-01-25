defmodule OsBlogWeb.Schema.LinkTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.LinkResolver

  object :link do
    field :id, :id, description: "ID"
    field :url, :string, description: "链接"
    field :title, :string, description: "链接标题"
    field :description, :string, description: "描述"
    field :order, :integer, description: "排序"
  end

  payload_paginate(:links_payload, :link)

  input_object :create_link_input do
    field :url, non_null(:string), description: "链接"
    field :title, :string, description: "链接标题"
    field :description, :string, description: "描述"
    field :order, :integer, description: "排序"
  end

  input_object :update_link_input do
    field :url, :string, description: "链接"
    field :title, :string, description: "链接标题"
    field :description, :string, description: "描述"
    field :order, :integer, description: "排序"
  end

  object :link_queries do
    field :links, :links_payload, description: "友情链接列表" do
      arg :page_params, :page_params, description: "页码信息"
      arg :id, :id, description: "ID"
      arg :url, :string, description: "链接"
      arg :title, :string, description: "链接标题"
      arg :description, :string, description: "描述"
      arg :order, :integer, description: "排序"

      resolve &LinkResolver.list_links/3
    end
  end

  object :link_mutations do
    field :create_link, :link, description: "新建友情链接" do
      arg :link, :create_link_input, description: "链接信息"

      resolve &LinkResolver.create_link/3
    end

    field :update_link, :link, description: "更新链接信息" do
      arg :id, non_null(:id), description: "ID"
      arg :link, :update_link_input, description: "链接信息"

      resolve &LinkResolver.update_link/3
    end

    field :delete_link, :link, description: "删除链接" do
      arg :id, non_null(:id), description: "ID"

      resolve &LinkResolver.delete_link/3
    end
  end
end
