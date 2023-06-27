defmodule InzynjerkaModelWeb.ChatbotController do
  use InzynjerkaModelWeb, :controller
  alias InzynjerkaModel.Chatbot

  def chatbot(conn, body) do
    similarity = Nx.Serving.batched_run(ChatApi.Serving, body["message"])
    response = Chatbot.get_answer_from_similarity(similarity)

    render(conn, :chatbot, response: response)
  end
end
