defmodule Calendar02.Repo.Migrations.CreateReasonsList do
  use Ecto.Migration

  def change do
    create table(:reasons_list) do
      add :name, :string
      add :reasion_id, :integer
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
