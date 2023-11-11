defmodule InzynjerkaModelWeb.ModelSettingsLive.Index do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Settings
  alias InzynjerkaModel.Settings.ModelSettings


  @impl true
  def mount( params, session, socket) do
      {:ok, stream(socket, :model_settings_collection, Settings.list_model_settings())}
  end


  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Model settings")
    |> assign(:model_settings, Settings.get_model_settings!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Model settings")
    |> assign(:model_settings, %ModelSettings{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Model settings")
    |> assign(:model_settings, nil)
  end

  @impl true
  def handle_info({InzynjerkaModelWeb.ModelSettingsLive.FormComponent, {:saved, model_settings}}, socket) do
    {:noreply, stream_insert(socket, :model_settings_collection, model_settings)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    model_settings = Settings.get_model_settings!(id)
    {:ok, _} = Settings.delete_model_settings(model_settings)

    {:noreply, stream_delete(socket, :model_settings_collection, model_settings)}
  end
end

