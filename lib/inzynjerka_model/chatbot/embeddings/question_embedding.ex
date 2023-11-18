defmodule InzynjerkaModel.Chatbot.Embeddings.QuestionEmbedding do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question_embeddings" do
    field :model, :string
    field :embeddings, {:array, :float}
    field :question_id, :id

    timestamps()
  end

  @doc false
  def changeset(question_embedding, attrs) do
    question_embedding
    |> cast(attrs, [:model, :embeddings])
    |> validate_required([:model, :embeddings])
  end

  def create_with_default_dates(attrs \\ %{}) do
    %{
      model: attrs.model,
      embeddings: attrs.embeddings,
      question_id: attrs.question_id,
      inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
      updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
    }
  end
end
