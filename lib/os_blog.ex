defmodule OsBlog do
  @moduledoc """
  OsBlog keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def schema do
    quote do
      use Ecto.Schema

      import Ecto.Query
      import Ecto.Changeset

      @timestamps_opts [type: :utc_datetime_usec]
    end
  end

  def context do
    quote do
      import Ecto.Query
      import Ecto.Changeset

      alias Ecto.Multi
      alias OsBlog.Repo
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
