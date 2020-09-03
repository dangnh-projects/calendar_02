defmodule Calendar02.Calendars.Reason do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reasons" do
    field :confirm, :boolean, default: false
    field :date_reason, :integer
    field :reason, :integer
    field :userid, :integer
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(reason, attrs) do
    reason
    |> cast(attrs, [:username, :userid, :date_reason, :reason, :confirm])
    |> validate_required([:username, :userid, :date_reason, :reason, :confirm])
  end
end