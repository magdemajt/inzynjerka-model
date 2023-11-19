defmodule InzynjerkaModelWeb.ChatbotJSON do

  def chatbot(%{ response: response }) do
    response |> case do
                  {:ok, answer, _} -> %{ answer: answer, send_to_human: false }
                  {:confidence_low, answer, _} -> %{ answer: answer, send_to_human: true }
                  {:confidence_too_low, answer, _} -> %{ send_to_human: true }
                  {:no_answer, answer, _} -> %{ send_to_human: true }
                  {:error} -> %{ send_to_human: false }
    end
  end

end
