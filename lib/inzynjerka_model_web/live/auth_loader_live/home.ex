defmodule InzynjerkaModelWeb.AuthLoaderLive.Home do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Settings
  alias InzynjerkaModel.Settings.ModelSettings

  @impl true
  def mount(params, session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Home")
  end
end
