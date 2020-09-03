defmodule Calendar02Web.PageController do
  use Calendar02Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
