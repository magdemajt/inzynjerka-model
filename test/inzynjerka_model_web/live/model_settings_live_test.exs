defmodule InzynjerkaModelWeb.ModelSettingsLiveTest do
  use InzynjerkaModelWeb.ConnCase

  import Phoenix.LiveViewTest
  import InzynjerkaModel.SettingsFixtures

  @create_attrs %{active: true, name: "some name", low_threshold: 42, high_threshold: 42}
  @update_attrs %{active: false, name: "some updated name", low_threshold: 43, high_threshold: 43}
  @invalid_attrs %{active: false, name: nil, low_threshold: nil, high_threshold: nil}

  defp create_model_settings(_) do
    model_settings = model_settings_fixture()
    %{model_settings: model_settings}
  end

  describe "Index" do
    setup [:create_model_settings]

    test "lists all model_settings", %{conn: conn, model_settings: model_settings} do
      {:ok, _index_live, html} = live(conn, ~p"/model_settings")

      assert html =~ "Listing Model settings"
      assert html =~ model_settings.name
    end

    test "saves new model_settings", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/model_settings")

      assert index_live |> element("a", "New Model settings") |> render_click() =~
               "New Model settings"

      assert_patch(index_live, ~p"/model_settings/new")

      assert index_live
             |> form("#model_settings-form", model_settings: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#model_settings-form", model_settings: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/model_settings")

      html = render(index_live)
      assert html =~ "Model settings created successfully"
      assert html =~ "some name"
    end

    test "updates model_settings in listing", %{conn: conn, model_settings: model_settings} do
      {:ok, index_live, _html} = live(conn, ~p"/model_settings")

      assert index_live |> element("#model_settings-#{model_settings.id} a", "Edit") |> render_click() =~
               "Edit Model settings"

      assert_patch(index_live, ~p"/model_settings/#{model_settings}/edit")

      assert index_live
             |> form("#model_settings-form", model_settings: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#model_settings-form", model_settings: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/model_settings")

      html = render(index_live)
      assert html =~ "Model settings updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes model_settings in listing", %{conn: conn, model_settings: model_settings} do
      {:ok, index_live, _html} = live(conn, ~p"/model_settings")

      assert index_live |> element("#model_settings-#{model_settings.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#model_settings-#{model_settings.id}")
    end
  end

  describe "Show" do
    setup [:create_model_settings]

    test "displays model_settings", %{conn: conn, model_settings: model_settings} do
      {:ok, _show_live, html} = live(conn, ~p"/model_settings/#{model_settings}")

      assert html =~ "Show Model settings"
      assert html =~ model_settings.name
    end

    test "updates model_settings within modal", %{conn: conn, model_settings: model_settings} do
      {:ok, show_live, _html} = live(conn, ~p"/model_settings/#{model_settings}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Model settings"

      assert_patch(show_live, ~p"/model_settings/#{model_settings}/show/edit")

      assert show_live
             |> form("#model_settings-form", model_settings: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#model_settings-form", model_settings: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/model_settings/#{model_settings}")

      html = render(show_live)
      assert html =~ "Model settings updated successfully"
      assert html =~ "some updated name"
    end
  end
end
