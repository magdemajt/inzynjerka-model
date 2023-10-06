defmodule InzynjerkaModel.Repo.Migrations.CreateModelSettings do
  use Ecto.Migration

  def change do
    create table(:model_settings) do
      add :active, :boolean, default: false, null: false
      add :low_threshold, :integer
      add :high_threshold, :integer
      add :name, :string

      timestamps()
    end
  end
end
