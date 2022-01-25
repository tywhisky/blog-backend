defmodule OsBlogWeb.Resolvers.SystemInfoResolver do
  use OsBlogWeb, :resolver

  alias OsBlog.SystemInfos

  def get_system_info(_parent, _args, _resolution) do
    SystemInfos.get_system_info()
  end

  def update_system_info(_parent, %{system_info: args}, _resolution),
    do: SystemInfos.update_system_info(args)
end
