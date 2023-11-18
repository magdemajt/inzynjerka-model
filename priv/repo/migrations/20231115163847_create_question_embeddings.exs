defmodule InzynjerkaModel.Repo.Migrations.CreateQuestionEmbeddings do
  use Ecto.Migration

  def change do
    create table(:question_embeddings) do
      add :model, :string
      add :embeddings, {:array, :float}
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:question_embeddings, [:question_id])
    create index(:question_embeddings, [:model])
  end
end
