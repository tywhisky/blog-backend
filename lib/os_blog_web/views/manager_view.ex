defmodule OsBlogWeb.ManagerView do
  use OsBlogWeb, :view
  alias OsBlogWeb.ManagerView

  def render("index.json", %{managers: managers}) do
    %{data: render_many(managers, ManagerView, "manager.json")}
  end

  def render("show.json", %{manager: manager}) do
    %{data: render_one(manager, ManagerView, "manager.json")}
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
end
