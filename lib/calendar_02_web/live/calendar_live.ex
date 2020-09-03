defmodule Calendar02Web.CalendarLive do
  #use Phoenix.LiveView
  #use Phoenix.LiveComponent
  use Calendar02Web, :live_view
  use Calendar02Web, :controller
  use Timex

  @week_start_at :mon

  def mount(_params, _session, socket) do
    current_date = Timex.now
    #assigns_day = Map.put(assigns, :day_class, day_class(assigns))

    assigns = [
      conn: socket,
      current_date: current_date,
      day_names: day_names(@week_start_at),
      week_rows: week_rows(current_date),
      date_picked: date_picked,
      show_modal: show_modal
    ]

    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    Calendar02Web.CalendarView.render("index.html", assigns)
  end

  defp date_picked() do
    date_picked = Timex.now()
  end

  def show_modal() do
    show_modal = false
  end

  defp day_names(:sun), do:  [7, 1, 2, 3, 4, 5, 6] |> Enum.map(&Timex.day_shortname/1)
  defp day_names(_), do:  [1, 2, 3, 4, 5, 6, 7] |> Enum.map(&Timex.day_shortname/1)

  defp week_rows(current_date) do
    first =
      current_date
      |> Timex.beginning_of_month()
      |> Timex.beginning_of_week(@week_start_at)

    last =
      current_date
      |> Timex.end_of_month()
      |> Timex.end_of_week(@week_start_at)

    Interval.new(from: first, until: last)
    |> Enum.map(& &1)
    |> Enum.chunk_every(7)
  end

  def handle_event("prev-month", _, socket) do
    current_date = Timex.shift(socket.assigns.current_date, months: -1)

    assigns = [
      current_date: current_date,
      week_rows: week_rows(current_date)
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("next-month", _, socket) do
    current_date = Timex.shift(socket.assigns.current_date, months: 1)

    assigns = [
      current_date: current_date,
      week_rows: week_rows(current_date)
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("pick-date", %{"date" => date}, socket) do
    current_date = Timex.parse!(date, "{YYYY}-{0M}-{D}")
    date_picked =  Timex.parse!(date, "{YYYY}-{0M}-{D}")

    assigns = [
      current_date: current_date,
      date_picked: date_picked,
      show_modal: true
    ]

    #IO.inspect date
    #Routes.page_path(@conn, :index)
    #Routes.page_path(:index)
    #Calendar02Web.Router.page_path(Calendar02Web.Endpoint, :index)
    {:noreply, assign(socket, assigns)}
  end

  def handle_event("left-button-click", _, socket) do
    assigns = [
      show_modal: false
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("right-button-click", %{"date" => date}, socket) do
    date_picked =  Timex.parse!(date, "{YYYY}-{0M}-{D}")

    id = "12313"

    IO.inspect date_picked
    {:noreply,
      push_redirect(socket,
        to: Routes.reason_path(socket, :new, date, id)
      )}
  end
end
