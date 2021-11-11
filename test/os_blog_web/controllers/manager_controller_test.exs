defmodule OsBlogWeb.ManagerControllerTest do
  use OsBlogWeb.ConnCase

  import OsBlog.AccountsFixtures

  alias OsBlog.Accounts.Manager

  @create_attrs %{
    avatar: "some avatar",
    email: "some email",
    name: "some name",
    password_digest: "some password_digest"
  }
  @update_attrs %{
    avatar: "some updated avatar",
    email: "some updated email",
    name: "some updated name",
    password_digest: "some updated password_digest"
  }
  @invalid_attrs %{avatar: nil, email: nil, name: nil, password_digest: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all managers", %{conn: conn} do
      conn = get(conn, Routes.manager_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create manager" do
    test "renders manager when data is valid", %{conn: conn} do
      conn = post(conn, Routes.manager_path(conn, :create), manager: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.manager_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "avatar" => "some avatar",
               "email" => "some email",
               "name" => "some name",
               "password_digest" => "some password_digest"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.manager_path(conn, :create), manager: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update manager" do
    setup [:create_manager]

    test "renders manager when data is valid", %{conn: conn, manager: %Manager{id: id} = manager} do
      conn = put(conn, Routes.manager_path(conn, :update, manager), manager: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.manager_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "avatar" => "some updated avatar",
               "email" => "some updated email",
               "name" => "some updated name",
               "password_digest" => "some updated password_digest"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, manager: manager} do
      conn = put(conn, Routes.manager_path(conn, :update, manager), manager: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete manager" do
    setup [:create_manager]

    test "deletes chosen manager", %{conn: conn, manager: manager} do
      conn = delete(conn, Routes.manager_path(conn, :delete, manager))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.manager_path(conn, :show, manager))
      end
    end
  end

  defp create_manager(_) do
    manager = manager_fixture()
    %{manager: manager}
  end
end
