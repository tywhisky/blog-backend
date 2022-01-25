defmodule OsBlogWeb.Schema.ManagerTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.ManagerResolver

  object :manager do
    field :id, non_null(:id), description: "ID"
    field :name, :string, description: "名字"
    field :email, non_null(:string), description: "邮箱"
    field :avatar, :string, description: "头像"
  end

  object :session do
    field :token, :string, description: "Token"
  end

  input_object :update_manager_input do
    field :name, :string, description: "名字"
    field :email, :string, description: "邮箱"
    field :password, :string, description: "新密码"
    field :avatar, :string, description: "头像"
  end

  object :manager_queries do
    field :profile, :manager, description: "获取管理员信息" do
      resolve(&ManagerResolver.get_manager/3)
    end
  end

  object :manager_mutations do
    field :login, type: :session, description: "登陆" do
      arg :email, non_null(:string), description: "邮箱"
      arg :password, non_null(:string), description: "密码"

      resolve &ManagerResolver.login/3
    end

    field :update_manager, type: :manager, description: "更新个人信息" do
      arg :manager, non_null(:update_manager_input), description: "个人信息"

      resolve &ManagerResolver.update_manager/3
    end
  end
end
