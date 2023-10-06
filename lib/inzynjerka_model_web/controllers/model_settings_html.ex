defmodule InzynjerkaModelWeb.ModelSettingsHTML do
  use InzynjerkaModelWeb, :html

  embed_templates "model_settings_html/*"

  @doc """
  Renders a model_settings form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def model_settings_form(assigns)
end
