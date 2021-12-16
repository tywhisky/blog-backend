defmodule OsBlogWeb.ManagerControllerTest do
  use OsBlogWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all managers", %{conn: conn} do
      conn = get(conn, Routes.manager_path(conn, :index))
      assert json_response(conn, 200)["items"] == []
    end
  end
end
