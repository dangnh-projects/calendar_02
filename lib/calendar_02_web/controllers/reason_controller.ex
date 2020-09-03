defmodule Calendar02Web.ReasonController do
  use Calendar02Web, :controller

  alias Calendar02.Calendars
  alias Calendar02.Calendars.Reason

  def index(conn, _params) do
    reasons = Calendars.list_reasons()
    render(conn, "index.html", reasons: reasons)
  end

  def new(conn, %{"date" => date, "id" => id}) do
    changeset = Calendars.change_reason(%Reason{})
    render(conn, "new.html", changeset: changeset)
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
    reason = Calendars.get_reason!(id)
    render(conn, "show.html", reason: reason)
  end

  def edit(conn, %{"id" => id}) do
    reason = Calendars.get_reason!(id)
    changeset = Calendars.change_reason(reason)
    render(conn, "edit.html", reason: reason, changeset: changeset)
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
