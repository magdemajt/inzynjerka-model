defmodule InzynjerkaModel.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false
  alias InzynjerkaModel.Repo

  alias InzynjerkaModel.Settings.ModelSettings

  @doc """
  Returns the list of model_settings.

  ## Examples

      iex> list_model_settings()
      [%ModelSettings{}, ...]

  """
  def list_model_settings do
    Repo.all(ModelSettings)
  end

  @doc """
  Gets a single model_settings.

  Raises `Ecto.NoResultsError` if the Model settings does not exist.

  ## Examples

      iex> get_model_settings!(123)
      %ModelSettings{}

      iex> get_model_settings!(456)
      ** (Ecto.NoResultsError)

  """
  def get_model_settings!(id), do: Repo.get!(ModelSettings, id)

  @doc """
  Creates a model_settings.

  ## Examples

      iex> create_model_settings(%{field: value})
      {:ok, %ModelSettings{}}

      iex> create_model_settings(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_model_settings(attrs \\ %{}) do
    %ModelSettings{}
    |> ModelSettings.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a model_settings.

  ## Examples

      iex> update_model_settings(model_settings, %{field: new_value})
      {:ok, %ModelSettings{}}

      iex> update_model_settings(model_settings, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_model_settings(%ModelSettings{} = model_settings, attrs) do
    model_settings
    |> ModelSettings.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a model_settings.

  ## Examples

      iex> delete_model_settings(model_settings)
      {:ok, %ModelSettings{}}

      iex> delete_model_settings(model_settings)
      {:error, %Ecto.Changeset{}}

  """
  def delete_model_settings(%ModelSettings{} = model_settings) do
    Repo.delete(model_settings)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking model_settings changes.

  ## Examples

      iex> change_model_settings(model_settings)
      %Ecto.Changeset{data: %ModelSettings{}}

  """
  def change_model_settings(%ModelSettings{} = model_settings, attrs \\ %{}) do
    ModelSettings.changeset(model_settings, attrs)
  end

  def get_most_recent_active_setting() do
    Repo.one(from ms in ModelSettings, where: ms.active == true, order_by: [desc: ms.inserted_at], limit: 1)
  end
end
