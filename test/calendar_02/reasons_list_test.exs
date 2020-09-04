defmodule Calendar02.ReasonsListTest do
  use Calendar02.DataCase

  alias Calendar02.ReasonsList

  describe "reasons_list" do
    alias Calendar02.ReasonsList.ReasonList

    @valid_attrs %{active: true, name: "some name", reasion_id: 42}
    @update_attrs %{active: false, name: "some updated name", reasion_id: 43}
    @invalid_attrs %{active: nil, name: nil, reasion_id: nil}

    def reason_list_fixture(attrs \\ %{}) do
      {:ok, reason_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ReasonsList.create_reason_list()

      reason_list
    end

    test "list_reasons_list/0 returns all reasons_list" do
      reason_list = reason_list_fixture()
      assert ReasonsList.list_reasons_list() == [reason_list]
    end

    test "get_reason_list!/1 returns the reason_list with given id" do
      reason_list = reason_list_fixture()
      assert ReasonsList.get_reason_list!(reason_list.id) == reason_list
    end

    test "create_reason_list/1 with valid data creates a reason_list" do
      assert {:ok, %ReasonList{} = reason_list} = ReasonsList.create_reason_list(@valid_attrs)
      assert reason_list.active == true
      assert reason_list.name == "some name"
      assert reason_list.reasion_id == 42
    end

    test "create_reason_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ReasonsList.create_reason_list(@invalid_attrs)
    end

    test "update_reason_list/2 with valid data updates the reason_list" do
      reason_list = reason_list_fixture()
      assert {:ok, %ReasonList{} = reason_list} = ReasonsList.update_reason_list(reason_list, @update_attrs)
      assert reason_list.active == false
      assert reason_list.name == "some updated name"
      assert reason_list.reasion_id == 43
    end

    test "update_reason_list/2 with invalid data returns error changeset" do
      reason_list = reason_list_fixture()
      assert {:error, %Ecto.Changeset{}} = ReasonsList.update_reason_list(reason_list, @invalid_attrs)
      assert reason_list == ReasonsList.get_reason_list!(reason_list.id)
    end

    test "delete_reason_list/1 deletes the reason_list" do
      reason_list = reason_list_fixture()
      assert {:ok, %ReasonList{}} = ReasonsList.delete_reason_list(reason_list)
      assert_raise Ecto.NoResultsError, fn -> ReasonsList.get_reason_list!(reason_list.id) end
    end

    test "change_reason_list/1 returns a reason_list changeset" do
      reason_list = reason_list_fixture()
      assert %Ecto.Changeset{} = ReasonsList.change_reason_list(reason_list)
    end
  end
end
