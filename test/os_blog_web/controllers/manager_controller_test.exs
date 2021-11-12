defmodule OsBlogWeb.ManagerControllerTest do
  use OsBlogWeb.ConnCase

  import OsBlog.AccountsFixtures

  @invalid_attrs %{avatar: nil, email: nil, name: nil, password_digest: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all managers", %{conn: conn} do
      conn = get(conn, Routes.manager_path(conn, :index))
      assert json_response(conn, 401)["data"] == nil
    end
  end

  describe "update manager" do
    setup [:create_manager]

    test "renders errors when data is invalid", %{conn: conn, manager: manager} do
      conn = put(conn, Routes.manager_path(conn, :update, manager), manager: @invalid_attrs)
      assert json_response(conn, 401)["errors"] != %{}
    end
  end

  defp create_manager(_) do
    manager = manager_fixture()
    %{manager: manager}
  end
end
