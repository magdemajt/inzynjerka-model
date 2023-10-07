defmodule InzynjerkaModel.Repo.Migrations.CreateQuestionAsks do
  use Ecto.Migration

  def change do
    create table(:question_asks) do
      add :similarity, :integer
      add :response_delay, :float
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:question_asks, [:question_id])
  end
end
