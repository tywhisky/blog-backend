defmodule OsBlog.Managers do
  use OsBlog, :context

  alias OsBlog.Repo
  alias OsBlog.Managers.Manager

  def get_manager() do
    manager = Repo.one!(Manager)

    {:ok, manager}
  end

  def update_manager(attrs) do
    Manager
    |> Repo.one!()
    |> Manager.update_changeset(attrs)
    |> Repo.update()
  end
end
