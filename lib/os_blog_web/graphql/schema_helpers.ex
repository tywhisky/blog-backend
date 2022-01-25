defmodule OsBlogWeb.SchemaHelpers do
  defmacro payload_paginate(payload_name, result_object_name) do
    quote location: :keep do
      object unquote(payload_name) do
        field :page_info, :page_info, description: "翻页信息"
        field :entries, list_of(unquote(result_object_name))
      end
    end
  end
end
