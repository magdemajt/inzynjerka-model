defmodule InzynjerkaModelWeb.QuestionStatisticsLive.MostFrequently do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Chatbot.Questions
  alias InzynjerkaModel.Chatbot.Questions.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :most_frequently, Questions.most_frequently(10))}
  end
  @impl true
  def handle_event("most-frequently", %{"limit" => limit}, socket) do
    # parse set to integer from string
    limit = String.to_integer(limit)
    most_frequently = Questions.most_frequently(limit)
    {:noreply, push_event(socket, "most-frequently", %{most_frequently: most_frequently})}
  end

end
