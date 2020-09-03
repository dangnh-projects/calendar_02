defmodule Calendar02.CalendarsTest do
  use Calendar02.DataCase

  alias Calendar02.Calendars

  describe "reasons" do
    alias Calendar02.Calendars.Reason

    @valid_attrs %{confirm: true, date_reason: 42, reason: 42, userid: 42, username: "some username"}
    @update_attrs %{confirm: false, date_reason: 43, reason: 43, userid: 43, username: "some updated username"}
    @invalid_attrs %{confirm: nil, date_reason: nil, reason: nil, userid: nil, username: nil}

    def reason_fixture(attrs \\ %{}) do
      {:ok, reason} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calendars.create_reason()

      reason
    end

    test "list_reasons/0 returns all reasons" do
      reason = reason_fixture()
      assert Calendars.list_reasons() == [reason]
    end

    test "get_reason!/1 returns the reason with given id" do
      reason = reason_fixture()
      assert Calendars.get_reason!(reason.id) == reason
    end

    test "create_reason/1 with valid data creates a reason" do
      assert {:ok, %Reason{} = reason} = Calendars.create_reason(@valid_attrs)
      assert reason.confirm == true
      assert reason.date_reason == 42
      assert reason.reason == 42
      assert reason.userid == 42
      assert reason.username == "some username"
    end

    test "create_reason/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calendars.create_reason(@invalid_attrs)
    end

    test "update_reason/2 with valid data updates the reason" do
      reason = reason_fixture()
      assert {:ok, %Reason{} = reason} = Calendars.update_reason(reason, @update_attrs)
      assert reason.confirm == false
      assert reason.date_reason == 43
      assert reason.reason == 43
      assert reason.userid == 43
      assert reason.username == "some updated username"
    end

    test "update_reason/2 with invalid data returns error changeset" do
      reason = reason_fixture()
      assert {:error, %Ecto.Changeset{}} = Calendars.update_reason(reason, @invalid_attrs)
      assert reason == Calendars.get_reason!(reason.id)
    end

    test "delete_reason/1 deletes the reason" do
      reason = reason_fixture()
      assert {:ok, %Reason{}} = Calendars.delete_reason(reason)
      assert_raise Ecto.NoResultsError, fn -> Calendars.get_reason!(reason.id) end
    end

    test "change_reason/1 returns a reason changeset" do
      reason = reason_fixture()
      assert %Ecto.Changeset{} = Calendars.change_reason(reason)
    end
  end
end
