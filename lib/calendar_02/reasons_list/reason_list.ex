defmodule Calendar02.ReasonsList.ReasonList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reasons_list" do
    field :active, :boolean, default: false
    field :name, :string
    field :reasion_id, :integer

    timestamps()
  end

  @doc false
  def changeset(reason_list, attrs) do
    reason_list
    |> cast(attrs, [:name, :reasion_id, :active])
    |> validate_required([:name, :reasion_id, :active])
  end
end
