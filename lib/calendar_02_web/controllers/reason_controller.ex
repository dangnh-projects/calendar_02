defmodule Calendar02Web.ReasonController do
  use Calendar02Web, :controller
  import Ecto.Query, warn: false
  alias Calendar02.Repo

  alias Calendar02.Calendars
  alias Calendar02.Calendars.Reason

  alias Calendar02.ReasonsList.ReasonList

  def index(conn, _params) do
    reasons = Calendars.list_reasons()
    IO.inspect reasons
    render(conn, "index.html", reasons: reasons)
  end

  def new(conn, %{"date" => date, "id" => id}) do
    query = from l in ReasonList, select: {l.name, l.id}
    reasons_list = Repo.all(query)
    changeset = Calendars.change_reason(%Reason{})
    render(conn, "new.html",reasons_list: reasons_list, changeset: changeset)
  end

  def create(conn, %{"reason" => reason_params}) do
    case Calendars.create_reason(reason_params) do
      {:ok, reason} ->
        conn
        |> put_flash(:info, "Reason created successfully.")
        |> redirect(to: Routes.reason_path(conn, :show, reason))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    {reason, list_reason} = Calendars.get_reason!(id)
    render(conn, "show.html", reason: reason, list_reason: list_reason)
  end

  def edit(conn, %{"id" => id}) do
    query = from l in ReasonList, select: {l.name, l.id}
    reasons_list = Repo.all(query)
    reason = Calendars.get_reason!(id)
    changeset = Calendars.change_reason(reason)
    render(conn, "edit.html", reason: reason, reasons_list: reasons_list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reason" => reason_params}) do
    reason = Calendars.get_reason!(id)

    case Calendars.update_reason(reason, reason_params) do
      {:ok, reason} ->
        conn
        |> put_flash(:info, "Reason updated successfully.")
        |> redirect(to: Routes.reason_path(conn, :show, reason))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reason: reason, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reason = Calendars.get_reason!(id)
    {:ok, _reason} = Calendars.delete_reason(reason)

    conn
    |> put_flash(:info, "Reason deleted successfully.")
    |> redirect(to: Routes.reason_path(conn, :index))
  end
end
