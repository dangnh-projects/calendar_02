defmodule Calendar02Web.CalendarLive do
  #use Phoenix.LiveView
  #use Phoenix.LiveComponent
  use Calendar02Web, :live_view
  use Timex

  def render(assigns) do
    ~L"""
    <div>
    <%= live_component(
          @socket,
          Calendar02Web.CalendarLiveComponent,
          title: "Assigns Title"
        )
    %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  # @week_start_at :mon

  # def mount(_session, socket) do
  #   current_date = Timex.now

  #   assigns = [
  #     conn: socket,
  #     current_date: current_date,
  #     day_names: day_names(@week_start_at),
  #     week_rows: week_rows(current_date)
  #   ]

  #   {:ok, assign(socket, assigns)}
  # end

  # # def render(assigns) do
  # #   Calendar02Web.CalendarView.render("index.html", assigns)
  # # end

  # def render(assigns) do
  #   ~L"""
  #   <h1>Title</h1>
  #   """
  # end

  # defp day_names(:sun), do:  [7, 1, 2, 3, 4, 5, 6] |> Enum.map(&Timex.day_shortname/1)
  # defp day_names(_), do:  [1, 2, 3, 4, 5, 6, 7] |> Enum.map(&Timex.day_shortname/1)

  # defp week_rows(current_date) do
  #   first =
  #     current_date
  #     |> Timex.beginning_of_month()
  #     |> Timex.beginning_of_week(@week_start_at)

  #   last =
  #     current_date
  #     |> Timex.end_of_month()
  #     |> Timex.end_of_week(@week_start_at)

  #   Interval.new(from: first, until: last)
  #   |> Enum.map(& &1)
  #   |> Enum.chunk_every(7)
  # end
end
