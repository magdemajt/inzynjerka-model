defmodule InzynjerkaModel.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :content, :text
      add :answer, :text
      add :is_displayed, :boolean, default: false, null: false
      add :language, :string

      timestamps()
    end

    create unique_index(:questions, [:content])
  end
end
