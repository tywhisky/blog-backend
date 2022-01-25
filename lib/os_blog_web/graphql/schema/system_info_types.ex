defmodule OsBlogWeb.Schema.SystemInfoTypes do
  use OsBlogWeb, :schema

  alias OsBlogWeb.Resolvers.SystemInfoResolver

  object :system_info do
    field :site_name, :string, description: "站点名称"
    field :site_desc, :string, description: "站点介绍"
    field :site_logi, :string, description: "站点LOGO"
    field :favicon, :string, description: "Favicon"
    field :foot_about, :string, description: "底部关于"
    field :foot_filing, :string, description: "底部备案"
    field :foot_copy_right, :string, description: "底部CopyRight"
    field :foot_powered_by, :string, description: "底部Powered_by"
    field :foot_powered_by_url, :string, description: "底部底部Powered_by URL"
  end

  input_object :system_info_input do
    field :site_name, :string, description: "站点名称"
    field :site_desc, :string, description: "站点介绍"
    field :site_logi, :string, description: "站点LOGO"
    field :favicon, :string, description: "Favicon"
    field :foot_about, :string, description: "底部关于"
    field :foot_filing, :string, description: "底部备案"
    field :foot_copy_right, :string, description: "底部CopyRight"
    field :foot_powered_by, :string, description: "底部Powered_by"
    field :foot_powered_by_url, :string, description: "底部底部Powered_by URL"
  end

  object :system_info_queries do
    field :system_info, :system_info, description: "获取系统信息" do
      resolve &SystemInfoResolver.get_system_info/3
    end
  end

  object :system_info_mutations do
    field :update_system_info, :system_info, description: "更新系统信息" do
      arg :system_info, :system_info_input, description: "链接信息"

      resolve &SystemInfoResolver.update_system_info/3
    end
  end
end
