defmodule Calendar02Web.CalendarLiveComponent do
  use Phoenix.LiveComponent
  use Timex

  def render(assigns) do
    assigns = Map.put(assigns, :day_class, day_class(assigns))

    ~L"""
    <td phx-click="pick-date" phx-value-date="<%= Timex.format!(@day, "%Y-%m-%d", :strftime) %>" class="<%= @day_class %>">
      <%= Timex.format!(@day, "%d", :strftime) %>
    </td>
    """
  end

  defp day_class(assigns) do
    cond do
      current_date?(assigns) ->
        "text-center text-2xl p-6 text-gray-600 border border-gray-200 bg-green-200 cursor-pointer"
      today?(assigns) ->
        "text-center text-2xl p-6 text-gray-600 border border-gray-200 bg-blue-100 bg-green-300:hover cursor-pointer"
      # weekend?(assigns) ->
      #   "text-center text-2xl p-6 text-gray-400 border border-gray-200 border-red-500 cursor-not-allowed"
      other_month?(assigns) ->
        "text-center text-2xl p-6 text-gray-400 border border-gray-200 bg-gray-200 cursor-not-allowed"
      true ->
        "text-center text-2xl p-6 text-gray-600 border border-gray-200 bg-white bg-blue-100:hover cursor-pointer"
    end
  end

  defp current_date?(assigns) do
    Map.take(assigns.day, [:year, :month, :day]) == Map.take(assigns.current_date, [:year, :month, :day])
    #IO.inspect assigns.current_date
  end

  defp today?(assigns) do
    Map.take(assigns.day, [:year, :month, :day]) == Map.take(Timex.now, [:year, :month, :day])
  end

  # defp weekend?(assigns) do
  #   (Timex.days_to_beginning_of_week(assigns.day) == 5 || Timex.days_to_beginning_of_week(assigns.day) == 6)
  #     && Map.take(assigns.day, [:year, :month]) == Map.take(assigns.current_date, [:year, :month])
  # end

  defp other_month?(assigns) do
    Map.take(assigns.day, [:year, :month]) != Map.take(assigns.current_date, [:year, :month])
  end
end
