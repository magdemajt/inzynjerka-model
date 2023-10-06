defmodule InzynjerkaModelWeb.ModelSettingsController do
  use InzynjerkaModelWeb, :controller

  alias InzynjerkaModel.Settings
  alias InzynjerkaModel.Settings.ModelSettings

  def index(conn, _params) do
    model_settings = Settings.list_model_settings()
    render(conn, :index, model_settings: model_settings)
  end

  def new(conn, _params) do
    changeset = Settings.change_model_settings(%ModelSettings{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"model_settings" => model_settings_params}) do
    case Settings.create_model_settings(model_settings_params) do
      {:ok, model_settings} ->
        conn
        |> put_flash(:info, "Model settings created successfully.")
        |> redirect(to: ~p"/model_settings/#{model_settings}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    model_settings = Settings.get_model_settings!(id)
    render(conn, :show, model_settings: model_settings)
  end

  def edit(conn, %{"id" => id}) do
    model_settings = Settings.get_model_settings!(id)
    changeset = Settings.change_model_settings(model_settings)
    render(conn, :edit, model_settings: model_settings, changeset: changeset)
  end

  def update(conn, %{"id" => id, "model_settings" => model_settings_params}) do
    model_settings = Settings.get_model_settings!(id)

    case Settings.update_model_settings(model_settings, model_settings_params) do
      {:ok, model_settings} ->
        conn
        |> put_flash(:info, "Model settings updated successfully.")
        |> redirect(to: ~p"/model_settings/#{model_settings}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, model_settings: model_settings, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    model_settings = Settings.get_model_settings!(id)
    {:ok, _model_settings} = Settings.delete_model_settings(model_settings)

    conn
    |> put_flash(:info, "Model settings deleted successfully.")
    |> redirect(to: ~p"/model_settings")
  end
end
