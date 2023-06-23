defmodule InzynjerkaModelWeb.ChatbotController do
  use InzynjerkaModelWeb, :controller

  def home(conn, %{message: body}) do
    response = Nx.Serving.batched_run(ChatApi.Serving, body)
    {:ok, predictions} = Map.fetch(response, "predictions")
    best = Enum.at(predictions, 0)
    %{ score: score, label: label } = best

    %{ score: score, label: label }
  end
end
