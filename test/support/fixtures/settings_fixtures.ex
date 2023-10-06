defmodule InzynjerkaModel.SettingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InzynjerkaModel.Settings` context.
  """

  @doc """
  Generate a model_settings.
  """
  def model_settings_fixture(attrs \\ %{}) do
    {:ok, model_settings} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name",
        low_threshold: 42,
        high_threshold: 42
      })
      |> InzynjerkaModel.Settings.create_model_settings()

    model_settings
  end
end
