defmodule OsBlogWeb.Schema.CommentTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.CommentResolver
  alias OsBlog.CommentStatusEnum

  enum :comment_status, values: CommentStatusEnum.values()

  object :comment do
    field :id, :id, description: "ID"
    field :body, :string, description: "回复内容"
    field :creator, :string, description: "创建人"
    field :creator_email, :string, description: "创建人邮箱"
    field :status, :comment_status, description: "状态"
    field :reply, :string, description: "作者回复"
    field :article_id, :id, description: "关联文章ID"
  end

  payload_paginate(:comments_payload, :comment)

  input_object :create_comment_input do
    field :body, non_null(:string), description: "回复内容"
    field :creator, non_null(:string), description: "创建人"
    field :creator_email, non_null(:string), description: "创建人邮箱"
    field :article_id, non_null(:id), description: "关联文章ID"
  end

  input_object :update_comment_input do
    field :status, :comment_status, description: "状态"
    field :reply, :string, description: "作者回复"
  end

  object :comment_queries do
    field :comments, :comments_payload, description: "评论列表" do
      arg :page_params, :page_params, description: "页码信息"
      arg :id, :id, description: "ID"
      arg :body, :string, description: "回复内容"
      arg :creator, :string, description: "创建人"
      arg :creator_email, :string, description: "创建人邮箱"
      arg :status, :comment_status, description: "状态"
      arg :reply, :string, description: "作者回复"
      arg :article_id, :id, description: "关联文章ID"

      resolve &CommentResolver.list_comments/3
    end
  end

  object :comment_mutations do
    field :create_comment, :comment, description: "新建评论" do
      arg :comment, :create_comment_input, description: "评论信息"

      resolve &CommentResolver.create_comment/3
    end

    field :update_comment, :comment, description: "更新链接信息" do
      arg :id, non_null(:id), description: "ID"
      arg :comment, :update_comment_input, description: "链接信息"

      resolve &CommentResolver.update_comment/3
    end

    field :delete_comment, :comment, description: "删除链接" do
      arg :id, non_null(:id), description: "ID"

      resolve &CommentResolver.delete_comment/3
    end
  end
end
