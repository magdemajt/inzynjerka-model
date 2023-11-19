defmodule InzynjerkaModelWeb.ChatbotController do
  import :timer
  use InzynjerkaModelWeb, :controller
  alias InzynjerkaModel.Chatbot
  alias InzynjerkaModel.Settings
  alias InzynjerkaModel.Settings.ModelSettings
  alias InzynjerkaModel.Chatbot.Questions.QuestionAsk
  alias InzynjerkaModel.Chatbot.Questions

  def chatbot(conn, body) do
    {time, result} = :timer.tc(fn -> chatbot_to_measure(conn, body) end)
    {result, chatbot_response} = result
    case chatbot_response do
      {:error} -> nil
      {_, _, metadata} -> chatbot_response
      _question = Questions.create_question_ask(%{similarity: trunc(metadata.max_value), response_delay: time, question_id: metadata.question_id})
    end
    result
  end

  defp chatbot_to_measure(conn, body) do
    response = if length(Questions.list_questions()) > 0 do
      similarity = Nx.Serving.batched_run(ChatApi.Serving, body["message"])
      response = Settings.get_most_recent_active_setting() |> case do
        nil -> Chatbot.get_answer_from_similarity(similarity, %{"low_threshold" => 80, "high_threshold" => 95})
        model_settings ->
          Chatbot.get_answer_from_similarity(similarity, %{"low_threshold" => model_settings.low_threshold, "high_threshold" => model_settings.high_threshold})
      end
      response |> case do
        {:confidence_too_low, answer, metadata} ->
          {:ok, new_question} = Questions.create_question(%{language: "Polish", content: body["message"], is_displayed: false, answer: nil})
          {:confidence_too_low, answer, %{question_id: new_question.id, max_value: metadata.max_value, max_index: metadata.max_index}}
        _ -> response
      end
    else
      {:error}
    end

    {render(conn, :chatbot, response: response), response}
  end
end
