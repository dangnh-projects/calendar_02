defmodule Calendar02Web.ReasonListControllerTest do
  use Calendar02Web.ConnCase

  alias Calendar02.ReasonsList

  @create_attrs %{active: true, name: "some name", reasion_id: 42}
  @update_attrs %{active: false, name: "some updated name", reasion_id: 43}
  @invalid_attrs %{active: nil, name: nil, reasion_id: nil}

  def fixture(:reason_list) do
    {:ok, reason_list} = ReasonsList.create_reason_list(@create_attrs)
    reason_list
  end

  describe "index" do
    test "lists all reasons_list", %{conn: conn} do
      conn = get(conn, Routes.reason_list_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reasons list"
    end
  end

  describe "new reason_list" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.reason_list_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reason list"
    end
  end

  describe "create reason_list" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reason_list_path(conn, :create), reason_list: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.reason_list_path(conn, :show, id)

      conn = get(conn, Routes.reason_list_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reason list"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reason_list_path(conn, :create), reason_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reason list"
    end
  end

  describe "edit reason_list" do
    setup [:create_reason_list]

    test "renders form for editing chosen reason_list", %{conn: conn, reason_list: reason_list} do
      conn = get(conn, Routes.reason_list_path(conn, :edit, reason_list))
      assert html_response(conn, 200) =~ "Edit Reason list"
    end
  end

  describe "update reason_list" do
    setup [:create_reason_list]

    test "redirects when data is valid", %{conn: conn, reason_list: reason_list} do
      conn = put(conn, Routes.reason_list_path(conn, :update, reason_list), reason_list: @update_attrs)
      assert redirected_to(conn) == Routes.reason_list_path(conn, :show, reason_list)

      conn = get(conn, Routes.reason_list_path(conn, :show, reason_list))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, reason_list: reason_list} do
      conn = put(conn, Routes.reason_list_path(conn, :update, reason_list), reason_list: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reason list"
    end
  end

  describe "delete reason_list" do
    setup [:create_reason_list]

    test "deletes chosen reason_list", %{conn: conn, reason_list: reason_list} do
      conn = delete(conn, Routes.reason_list_path(conn, :delete, reason_list))
      assert redirected_to(conn) == Routes.reason_list_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.reason_list_path(conn, :show, reason_list))
      end
    end
  end

  defp create_reason_list(_) do
    reason_list = fixture(:reason_list)
    %{reason_list: reason_list}
  end
end
