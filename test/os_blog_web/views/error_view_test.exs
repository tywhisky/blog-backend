defmodule OsBlogWeb.ErrorViewTest do
  use OsBlogWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(OsBlogWeb.ErrorView, "404.json", []) == %{code: :not_found, status: 404}
  end

  test "renders 500.json" do
    assert render(OsBlogWeb.ErrorView, "500.json", []) ==
             %{code: :internal_server_error, status: 500}
  end
end
