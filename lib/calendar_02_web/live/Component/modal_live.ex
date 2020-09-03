defmodule Calendar02Web.Component.ModalLive do
  use Phoenix.LiveComponent

  @defaults %{
    left_button: "Cancel",
    left_button_action: nil,
    left_button_param: nil,
    right_button: "OK",
    right_button_action: nil,
    right_button_param: nil
  }

  @spec render(map()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <div>
      <div class="modal-container" phx-hook="ScrollLock">
        <div class="modal-inner-container">
          <div class="modal-card">
            <div class="modal-inner-card">
              <!-- Title -->
              <%= if @title != nil do %>
              <div class="modal-title">
                <%= @title %>
              </div>
              <% end %>

              <!-- Body -->
              <%= if @body != nil do %>
                <div class="modal-body">
                  <%= @body %>
                </div>
              <% end %>

              <div class="modal-buttons">
                <!-- Left Button -->
                <button class="left-button"
                        type="button"
                        phx-click="left-button-click">
                  <div>
                    <%= @left_button %>
                  </div>
                </button>
                <!-- Right Button -->
                <button class="right-button"
                        type="button"
                        phx-click="right-button-click"
                        phx-value-date="<%= Timex.format!(@date_picked, "%Y-%m-%d", :strftime) %>">
                  <div>
                    <%= @right_button %>
                  </div>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    current_date = Timex.now
    #assigns_day = Map.put(assigns, :day_class, day_class(assigns))

    assigns = [
      conn: socket,
      current_date: current_date
    ]

    {:ok, assign(socket, assigns)}
  end
end
