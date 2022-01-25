defmodule OsBlogWeb.Schema.PaginationTypes do
  use OsBlogWeb, :schema

  input_object :page_params, description: "翻页参数" do
    field :page, :integer, description: "页码"
    field :page_size, :integer, description: "每页记录数"
  end

  object :page_info, description: "翻页信息" do
    field :page_number, :integer, description: "当前页码"
    field :page_size, :integer, description: "每页记录数"
    field :total_pages, :integer, description: "总页数"
    field :total_entries, :integer, description: "总记录数"
  end
end
