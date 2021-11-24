defmodule OsBlogWeb.ErrorView do
  use OsBlogWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def render(<<status::binary-3>> <> ".json", %{code: code} = assigns) do
    json = %{
      status: String.to_integer(status),
      code: code
    }

    errors = Map.get(assigns, :errors)
    if errors, do: Map.put(json, :errors, errors), else: json
  end

  # 处理 Phoenix.ActionClauseError 并返回 400
  def render("400.json", _assigns) do
    %{status: 400, code: :bad_request}
  end

  # Phoenix 会捕获异常并调用 ErrorView.render/2
  def render("404.json", _assigns) do
    %{status: 404, code: :not_found}
  end

  def render("500.json", _assigns) do
    %{status: 500, code: :internal_server_error}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, _assigns) do
    %{status: 500, code: :internal_server_error}
  end
end
