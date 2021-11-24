defmodule OsBlogWeb.ManagerView do
  use OsBlogWeb, :view
  alias OsBlogWeb.ManagerView
  alias OsBlogWeb.ViewPaginationHelpers

  def render("index.json", %{page: page}) do
    ViewPaginationHelpers.render_page(page, &manager_json/1)
  end

  def render("show.json", %{manager: manager}) do
    %{data: render_one(manager, ManagerView, "manager.json")}
  end

  def render("login.json", token) do
    %{data: Map.take(token, [:token])}
  end

  def render("manager.json", %{manager: manager}) do
    %{
      id: manager.id,
      name: manager.name,
      email: manager.email,
      password_digest: manager.password_digest,
      avatar: manager.avatar
    }
  end

  def manager_json(manager) do
    manager
    |> Map.take([
      :id,
      :name,
      :email,
      :avatar
    ])
  end
end
