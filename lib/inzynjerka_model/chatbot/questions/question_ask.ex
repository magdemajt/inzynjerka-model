defmodule InzynjerkaModel.Chatbot.Questions.QuestionAsk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question_asks" do
    field :similarity, :integer
    field :response_delay, :float
    field :question_id, :id

    timestamps()
  end

  @doc false
  def changeset(question_ask, attrs) do
    question_ask
    |> cast(attrs, [:similarity, :response_delay, :question_id])
    |> validate_required([:similarity, :response_delay, :question_id])
  end
end
