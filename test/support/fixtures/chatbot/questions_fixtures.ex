defmodule InzynjerkaModel.Chatbot.QuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InzynjerkaModel.Chatbot.Questions` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        language: "some language",
        content: "some content",
        answer: "some answer",
        is_displayed: true
      })
      |> InzynjerkaModel.Chatbot.Questions.create_question()

    question
  end

  @doc """
  Generate a question_ask.
  """
  def question_ask_fixture(attrs \\ %{}) do
    {:ok, question_ask} =
      attrs
      |> Enum.into(%{
        similarity: 42,
        response_delay: 120.5
      })
      |> InzynjerkaModel.Chatbot.Questions.create_question_ask()

    question_ask
  end
end
