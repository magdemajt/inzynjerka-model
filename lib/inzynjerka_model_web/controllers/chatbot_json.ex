defmodule InzynjerkaModelWeb.ChatbotJSON do

  def chatbot(%{ response: response }) do
    %{ data: %{ response: response } }
  end

end
