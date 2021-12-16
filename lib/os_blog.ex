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
      import EctoEnum, only: [defenum: 2]

      @timestamps_opts [type: :naive_datetime_usec]
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
