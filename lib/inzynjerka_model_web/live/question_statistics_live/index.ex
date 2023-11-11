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

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Question")
    |> assign(:question, Questions.get_question!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Question")
    |> assign(:question, %Question{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Questions")
    |> assign(:question, nil)
  end

  @impl true
  def handle_info({InzynjerkaModelWeb.QuestionLive.FormComponent, {:saved, question}}, socket) do
    {:noreply, stream_insert(socket, :questions, question)}
  end

  @impl true
  def handle_event("get_statistics", %{}, socket) do
    statistics = Questions.get_statistics()
    {:noreply, push_event(socket, "statistics", statistics)}
  end
end
