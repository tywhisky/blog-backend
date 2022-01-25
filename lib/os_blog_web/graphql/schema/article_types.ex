defmodule OsBlogWeb.Schema.ArticleTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.ArticleResolver
  alias OsBlog.ArticleStatusEnum

  enum :article_status, values: ArticleStatusEnum.values()

  object :article do
    field :id, non_null(:id), description: "ID"
    field :title, :string, description: "文章标题"
    field :body, :string, description: "文章内容"
    field :cover, :string, description: "文章封面"
    field :clicks, :integer, description: "点击量"
    field :status, :article_status, description: "文章状态"

    field :category, :category,
      description: "文章分类",
      resolve: dataloader(OsBlogDataloader)
  end

  payload_paginate(:articles_payload, :article)

  input_object :create_article_input do
    field :title, non_null(:string), description: "文章标题"
    field :cover, :string, description: "文章封面"
    field :body, :string, description: "文章内容"
    field :category_id, :string, description: "文章分类ID"
  end

  input_object :update_article_input do
    field :title, :string, description: "文章标题"
    field :body, :string, description: "文章内容"
    field :clicks, :integer, description: "点击量"
    field :cover, :string, description: "文章封面"
    field :status, :article_status, description: "文章状态"
    field :category_id, :string, description: "文章分类ID"
  end

  object :article_queries do
    field :article, :article, description: "文章详情" do
      arg :id, non_null(:id), description: "ID"
      resolve &ArticleResolver.get_article/3
    end

    field :articles, :articles_payload, description: "文章列表" do
      arg :page_params, :page_params, description: "页码信息"
      arg :title, :string, description: "文章标题"
      arg :cover, :string, description: "文章封面"
      arg :clicks, :integer, description: "点击量"
      arg :status, :article_status, description: "文章状态"
      arg :category_id, :integer, description: "分类ID"

      resolve &ArticleResolver.list_articles/3
    end
  end

  object :article_mutations do
    field :create_article, type: :article, description: "新建文章" do
      arg :article, non_null(:create_article_input), description: "文章信息"

      resolve &ArticleResolver.create_article/3
    end

    field :update_article, type: :article, description: "更新文章" do
      arg :id, non_null(:id), description: "文章ID"
      arg :article, non_null(:update_article_input), description: "文章信息"

      resolve &ArticleResolver.update_article/3
    end
  end
end
