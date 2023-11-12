defmodule InzynjerkaModelWeb.QuestionStatisticsLive.Index do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Chatbot.Questions
  alias InzynjerkaModel.Chatbot.Questions.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :question_asks, Questions.list_question_answers())}
  end



  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Questions")
    |> assign(:question, nil)
  end

  @impl true
  def handle_event("get_statistics", %{}, socket) do
    statistics = Questions.get_statistics()
    {:noreply, push_event(socket, "statistics", statistics)}
  end


  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    question_ask = Questions.get_question_ask!(id)
    {:ok, _} = Questions.delete_question_ask(question_ask)
    {:noreply, stream_delete(socket, :question_asks, question_ask)}
  end
end
