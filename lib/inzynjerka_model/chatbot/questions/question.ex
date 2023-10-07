defmodule InzynjerkaModel.Chatbot.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :language, :string
    field :content, :string
    field :answer, :string, default: nil
    field :is_displayed, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:content, :answer, :is_displayed, :language])
    |> validate_required([:content, :is_displayed, :language])
  end
end
