defmodule Calendar02.Repo.Migrations.CreateReasons do
  use Ecto.Migration

  def change do
    create table(:reasons) do
      add :username, :string
      add :userid, :integer
      add :date_reason, :integer
      add :reason, :integer
      add :confirm, :boolean, default: false, null: false

      timestamps()
    end

  end
end
