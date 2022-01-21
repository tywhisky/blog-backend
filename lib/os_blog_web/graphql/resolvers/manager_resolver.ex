defmodule OsBlogWeb.Resolvers.ManagerResolver do
  alias OsBlog.Managers

  def get_manager(_parent, _args, _resolution) do
    Managers.get_manager()
  end

  def update_manager(_parent, %{manager: args}, _resolution), do: Managers.update_manager(args)
end
