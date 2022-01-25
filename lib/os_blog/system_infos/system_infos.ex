defmodule OsBlog.SystemInfos do
  use OsBlog, :context

  alias OsBlog.Repo
  alias OsBlog.SystemInfos.SystemInfo

  def get_system_info() do
    system_info = Repo.one!(SystemInfo)

    {:ok, system_info}
  end

  def update_system_info(attrs) do
    SystemInfo
    |> Repo.one!()
    |> SystemInfo.update_changeset(attrs)
    |> Repo.update()
  end
end
