defmodule InzynjerkaModel.Chatbot.EmbeddingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InzynjerkaModel.Chatbot.Embeddings` context.
  """

  @doc """
  Generate a question_embedding.
  """
  def question_embedding_fixture(attrs \\ %{}) do
    {:ok, question_embedding} =
      attrs
      |> Enum.into(%{
        model: "some model",
        embeddings: "some embeddings"
      })
      |> InzynjerkaModel.Chatbot.Embeddings.create_question_embedding()

    question_embedding
  end
end
