defmodule Calendar02Web.ReasonListController do
  use Calendar02Web, :controller

  alias Calendar02.ReasonsList
  alias Calendar02.ReasonsList.ReasonList

  def index(conn, _params) do
    reasons_list = ReasonsList.list_reasons_list()
    render(conn, "index.html", reasons_list: reasons_list)
  end

  def new(conn, _params) do
    changeset = ReasonsList.change_reason_list(%ReasonList{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reason_list" => reason_list_params}) do
    case ReasonsList.create_reason_list(reason_list_params) do
      {:ok, reason_list} ->
        conn
        |> put_flash(:info, "Reason list created successfully.")
        |> redirect(to: Routes.reason_list_path(conn, :show, reason_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reason_list = ReasonsList.get_reason_list!(id)
    render(conn, "show.html", reason_list: reason_list)
  end

  def edit(conn, %{"id" => id}) do
    reason_list = ReasonsList.get_reason_list!(id)
    changeset = ReasonsList.change_reason_list(reason_list)
    render(conn, "edit.html", reason_list: reason_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reason_list" => reason_list_params}) do
    reason_list = ReasonsList.get_reason_list!(id)

    case ReasonsList.update_reason_list(reason_list, reason_list_params) do
      {:ok, reason_list} ->
        conn
        |> put_flash(:info, "Reason list updated successfully.")
        |> redirect(to: Routes.reason_list_path(conn, :show, reason_list))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reason_list: reason_list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reason_list = ReasonsList.get_reason_list!(id)
    {:ok, _reason_list} = ReasonsList.delete_reason_list(reason_list)

    conn
    |> put_flash(:info, "Reason list deleted successfully.")
    |> redirect(to: Routes.reason_list_path(conn, :index))
  end
end
