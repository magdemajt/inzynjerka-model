defmodule InzynjerkaModelWeb.QuestionStatisticsLive.MostFrequently do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Chatbot.Questions
  alias InzynjerkaModel.Chatbot.Questions.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :question_ask_count, Questions.question_ask_count())}
  end
end
