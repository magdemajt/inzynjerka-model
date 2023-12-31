defmodule InzynjerkaModelWeb.AuthLoaderLive.Index do
  use InzynjerkaModelWeb, :live_view

  alias InzynjerkaModel.Settings
  alias InzynjerkaModel.Settings.ModelSettings

  @impl true
  def mount(params, session, socket) do
    session = Map.put_new(session, :token, "")
    {:ok, assign(socket, :session, session)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Authenticating")
  end

  @impl true
  def handle_event("update_token", %{"token" => token}, socket) do
    session = socket.assigns[:session]
    session = Map.put(session, :token, token)
    {:noreply, push_redirect(socket, to: ~p"/home", replace: true)}
  end
end
