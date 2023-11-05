defmodule InzynjerkaModelWeb.ModelSettingsLive.FormComponent do
  use InzynjerkaModelWeb, :live_component

  alias InzynjerkaModel.Settings

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage model_settings records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="model_settings-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
        phx-hook="AddToken"
      >
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <.input field={@form[:low_threshold]} type="number" label="Low threshold" />
        <.input field={@form[:high_threshold]} type="number" label="High threshold" />
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <button phx-disable-with="Saving...">Save Model settings</button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{model_settings: model_settings} = assigns, socket) do
    changeset = Settings.change_model_settings(model_settings)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"model_settings" => model_settings_params}, socket) do
    changeset =
      socket.assigns.model_settings
      |> Settings.change_model_settings(model_settings_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"model_settings" => model_settings_params}, socket) do
    save_model_settings(socket, socket.assigns.action, model_settings_params)
  end

  defp save_model_settings(socket, :edit, model_settings_params) do
    case Settings.update_model_settings(socket.assigns.model_settings, model_settings_params) do
      {:ok, model_settings} ->
        notify_parent({:saved, model_settings})

        {:noreply,
         socket
         |> put_flash(:info, "Model settings updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_model_settings(socket, :new, model_settings_params) do
    case Settings.create_model_settings(model_settings_params) do
      {:ok, model_settings} ->
        notify_parent({:saved, model_settings})

        {:noreply,
         socket
         |> put_flash(:info, "Model settings created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
