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
        email: "test@gmail.com",
        name: "some name",
        password: "some password"
      })
      |> OsBlog.Accounts.create_manager()

    manager
  end
end
