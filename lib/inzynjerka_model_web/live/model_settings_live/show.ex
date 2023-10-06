defmodule InzynjerkaModelWeb.ModelSettingsLive.Show do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Settings

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:model_settings, Settings.get_model_settings!(id))}
  end

  defp page_title(:show), do: "Show Model settings"
  defp page_title(:edit), do: "Edit Model settings"
end
