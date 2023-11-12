defmodule InzynjerkaModelWeb.QuestionStatisticsLive.NotAnswered do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Chatbot.Questions
  alias InzynjerkaModel.Chatbot.Questions.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, push_event(socket, "not-answered", %{data: Questions.not_answered(10), limit: 10})}
  end

  @impl true
  def handle_event("not-answered", %{"limit" => limit}, socket) do
    limit = String.to_integer(limit)
    data = Questions.not_answered(limit)
    {:noreply, push_event(socket, "not-answered", %{data: data, limit: limit})}
  end

end
