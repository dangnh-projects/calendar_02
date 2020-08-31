defmodule Calendar02.Repo do
  use Ecto.Repo,
    otp_app: :calendar_02,
    adapter: Ecto.Adapters.Tds
end
