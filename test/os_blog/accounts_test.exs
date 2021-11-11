defmodule OsBlog.AccountsTest do
  use OsBlog.DataCase

  alias OsBlog.Accounts

  describe "managers" do
    alias OsBlog.Accounts.Manager

    import OsBlog.AccountsFixtures

    @invalid_attrs %{avatar: nil, email: nil, name: nil, password_digest: nil}

    test "list_managers/0 returns all managers" do
      manager = manager_fixture()
      assert Accounts.list_managers() == [manager]
    end

    test "get_manager!/1 returns the manager with given id" do
      manager = manager_fixture()
      assert Accounts.get_manager!(manager.id) == manager
    end

    test "create_manager/1 with valid data creates a manager" do
      valid_attrs = %{avatar: "some avatar", email: "some email", name: "some name", password_digest: "some password_digest"}

      assert {:ok, %Manager{} = manager} = Accounts.create_manager(valid_attrs)
      assert manager.avatar == "some avatar"
      assert manager.email == "some email"
      assert manager.name == "some name"
      assert manager.password_digest == "some password_digest"
    end

    test "create_manager/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_manager(@invalid_attrs)
    end

    test "update_manager/2 with valid data updates the manager" do
      manager = manager_fixture()
      update_attrs = %{avatar: "some updated avatar", email: "some updated email", name: "some updated name", password_digest: "some updated password_digest"}

      assert {:ok, %Manager{} = manager} = Accounts.update_manager(manager, update_attrs)
      assert manager.avatar == "some updated avatar"
      assert manager.email == "some updated email"
      assert manager.name == "some updated name"
      assert manager.password_digest == "some updated password_digest"
    end

    test "update_manager/2 with invalid data returns error changeset" do
      manager = manager_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_manager(manager, @invalid_attrs)
      assert manager == Accounts.get_manager!(manager.id)
    end

    test "delete_manager/1 deletes the manager" do
      manager = manager_fixture()
      assert {:ok, %Manager{}} = Accounts.delete_manager(manager)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_manager!(manager.id) end
    end

    test "change_manager/1 returns a manager changeset" do
      manager = manager_fixture()
      assert %Ecto.Changeset{} = Accounts.change_manager(manager)
    end
  end
end
