defmodule InzynjerkaModelWeb.ModelSettingsControllerTest do
  use InzynjerkaModelWeb.ConnCase

  import InzynjerkaModel.SettingsFixtures

  @create_attrs %{active: true, name: "some name", low_threshold: 42, high_threshold: 42}
  @update_attrs %{active: false, name: "some updated name", low_threshold: 43, high_threshold: 43}
  @invalid_attrs %{active: nil, name: nil, low_threshold: nil, high_threshold: nil}

  describe "index" do
    test "lists all model_settings", %{conn: conn} do
      conn = get(conn, ~p"/model_settings")
      assert html_response(conn, 200) =~ "Listing Model settings"
    end
  end

  describe "new model_settings" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/model_settings/new")
      assert html_response(conn, 200) =~ "New Model settings"
    end
  end

  describe "create model_settings" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/model_settings", model_settings: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/model_settings/#{id}"

      conn = get(conn, ~p"/model_settings/#{id}")
      assert html_response(conn, 200) =~ "Model settings #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/model_settings", model_settings: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Model settings"
    end
  end

  describe "edit model_settings" do
    setup [:create_model_settings]

    test "renders form for editing chosen model_settings", %{conn: conn, model_settings: model_settings} do
      conn = get(conn, ~p"/model_settings/#{model_settings}/edit")
      assert html_response(conn, 200) =~ "Edit Model settings"
    end
  end

  describe "update model_settings" do
    setup [:create_model_settings]

    test "redirects when data is valid", %{conn: conn, model_settings: model_settings} do
      conn = put(conn, ~p"/model_settings/#{model_settings}", model_settings: @update_attrs)
      assert redirected_to(conn) == ~p"/model_settings/#{model_settings}"

      conn = get(conn, ~p"/model_settings/#{model_settings}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, model_settings: model_settings} do
      conn = put(conn, ~p"/model_settings/#{model_settings}", model_settings: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Model settings"
    end
  end

  describe "delete model_settings" do
    setup [:create_model_settings]

    test "deletes chosen model_settings", %{conn: conn, model_settings: model_settings} do
      conn = delete(conn, ~p"/model_settings/#{model_settings}")
      assert redirected_to(conn) == ~p"/model_settings"

      assert_error_sent 404, fn ->
        get(conn, ~p"/model_settings/#{model_settings}")
      end
    end
  end

  defp create_model_settings(_) do
    model_settings = model_settings_fixture()
    %{model_settings: model_settings}
  end
end
