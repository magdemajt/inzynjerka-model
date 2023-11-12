defmodule InzynjerkaModelWeb.QuestionStatisticsLive.MostFrequently do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Chatbot.Questions
  alias InzynjerkaModel.Chatbot.Questions.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, push_event(socket, "most-frequently", %{data: Questions.most_frequently(10), limit: 10})}
  end

  @impl true
  def handle_event("most-frequently", %{"limit" => limit}, socket) do
    limit = String.to_integer(limit)
    data = Questions.most_frequently(limit)
    {:noreply, push_event(socket, "most-frequently", %{data: data, limit: limit})}
  end

end
