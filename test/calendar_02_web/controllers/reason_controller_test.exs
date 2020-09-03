defmodule Calendar02Web.ReasonControllerTest do
  use Calendar02Web.ConnCase

  alias Calendar02.Calendars

  @create_attrs %{confirm: true, date_reason: 42, reason: 42, userid: 42, username: "some username"}
  @update_attrs %{confirm: false, date_reason: 43, reason: 43, userid: 43, username: "some updated username"}
  @invalid_attrs %{confirm: nil, date_reason: nil, reason: nil, userid: nil, username: nil}

  def fixture(:reason) do
    {:ok, reason} = Calendars.create_reason(@create_attrs)
    reason
  end

  describe "index" do
    test "lists all reasons", %{conn: conn} do
      conn = get(conn, Routes.reason_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reasons"
    end
  end

  describe "new reason" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.reason_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reason"
    end
  end

  describe "create reason" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reason_path(conn, :create), reason: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.reason_path(conn, :show, id)

      conn = get(conn, Routes.reason_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Reason"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reason_path(conn, :create), reason: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reason"
    end
  end

  describe "edit reason" do
    setup [:create_reason]

    test "renders form for editing chosen reason", %{conn: conn, reason: reason} do
      conn = get(conn, Routes.reason_path(conn, :edit, reason))
      assert html_response(conn, 200) =~ "Edit Reason"
    end
  end

  describe "update reason" do
    setup [:create_reason]

    test "redirects when data is valid", %{conn: conn, reason: reason} do
      conn = put(conn, Routes.reason_path(conn, :update, reason), reason: @update_attrs)
      assert redirected_to(conn) == Routes.reason_path(conn, :show, reason)

      conn = get(conn, Routes.reason_path(conn, :show, reason))
      assert html_response(conn, 200) =~ "some updated username"
    end

    test "renders errors when data is invalid", %{conn: conn, reason: reason} do
      conn = put(conn, Routes.reason_path(conn, :update, reason), reason: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Reason"
    end
  end

  describe "delete reason" do
    setup [:create_reason]

    test "deletes chosen reason", %{conn: conn, reason: reason} do
      conn = delete(conn, Routes.reason_path(conn, :delete, reason))
      assert redirected_to(conn) == Routes.reason_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.reason_path(conn, :show, reason))
      end
    end
  end

  defp create_reason(_) do
    reason = fixture(:reason)
    %{reason: reason}
  end
end
