defmodule OsBlog.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OsBlog.Accounts` context.
  """

  @doc """
  Generate a manager.
  """
  def manager_fixture(attrs \\ %{}) do
    {:ok, manager} =
      attrs
      |> Enum.into(%{
        avatar: "some avatar",
        email: "some email",
        name: "some name",
        password_digest: "some password_digest"
      })
      |> OsBlog.Accounts.create_manager()

    manager
  end
end
