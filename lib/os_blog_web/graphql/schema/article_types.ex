defmodule OsBlogWeb.Schema.ArticleTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.ArticleResolver
  alias OsBlog.Articles.Category
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
      resolve: dataloader(Category, :name, use_parent: false)
  end

  input_object :create_article_input do
    field :title, non_null(:string), description: "文章标题"
    field :cover, :string, description: "文章封面"
    field :body, :string, description: "文章内容"
    field :category_id, :string, description: "文章分类ID"
  end

  object :article_mutations do
    field :create_article, type: :article, description: "新建文章" do
      arg :article, non_null(:create_article_input), description: "文章信息"

      resolve &ArticleResolver.create_article/3
    end
  end
end