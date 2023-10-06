defmodule InzynjerkaModel.SettingsTest do
  use InzynjerkaModel.DataCase

  alias InzynjerkaModel.Settings

  describe "model_settings" do
    alias InzynjerkaModel.Settings.ModelSettings

    import InzynjerkaModel.SettingsFixtures

    @invalid_attrs %{active: nil, name: nil, low_threshold: nil, high_threshold: nil}

    test "list_model_settings/0 returns all model_settings" do
      model_settings = model_settings_fixture()
      assert Settings.list_model_settings() == [model_settings]
    end

    test "get_model_settings!/1 returns the model_settings with given id" do
      model_settings = model_settings_fixture()
      assert Settings.get_model_settings!(model_settings.id) == model_settings
    end

    test "create_model_settings/1 with valid data creates a model_settings" do
      valid_attrs = %{active: true, name: "some name", low_threshold: 42, high_threshold: 42}

      assert {:ok, %ModelSettings{} = model_settings} = Settings.create_model_settings(valid_attrs)
      assert model_settings.active == true
      assert model_settings.name == "some name"
      assert model_settings.low_threshold == 42
      assert model_settings.high_threshold == 42
    end

    test "create_model_settings/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Settings.create_model_settings(@invalid_attrs)
    end

    test "update_model_settings/2 with valid data updates the model_settings" do
      model_settings = model_settings_fixture()
      update_attrs = %{active: false, name: "some updated name", low_threshold: 43, high_threshold: 43}

      assert {:ok, %ModelSettings{} = model_settings} = Settings.update_model_settings(model_settings, update_attrs)
      assert model_settings.active == false
      assert model_settings.name == "some updated name"
      assert model_settings.low_threshold == 43
      assert model_settings.high_threshold == 43
    end

    test "update_model_settings/2 with invalid data returns error changeset" do
      model_settings = model_settings_fixture()
      assert {:error, %Ecto.Changeset{}} = Settings.update_model_settings(model_settings, @invalid_attrs)
      assert model_settings == Settings.get_model_settings!(model_settings.id)
    end

    test "delete_model_settings/1 deletes the model_settings" do
      model_settings = model_settings_fixture()
      assert {:ok, %ModelSettings{}} = Settings.delete_model_settings(model_settings)
      assert_raise Ecto.NoResultsError, fn -> Settings.get_model_settings!(model_settings.id) end
    end

    test "change_model_settings/1 returns a model_settings changeset" do
      model_settings = model_settings_fixture()
      assert %Ecto.Changeset{} = Settings.change_model_settings(model_settings)
    end
  end
end
