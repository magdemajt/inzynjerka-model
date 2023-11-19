defmodule InzynjerkaModel.Settings.ModelSettings do
  use Ecto.Schema
  import Ecto.Changeset

  schema "model_settings" do
    field :active, :boolean, default: false
    field :name, :string
    field :low_threshold, :integer
    field :high_threshold, :integer

    timestamps()
  end

  @doc false
  def changeset(model_settings, attrs) do
    model_settings
    |> cast(attrs, [:active, :low_threshold, :high_threshold, :name])
    |> validate_required([:active, :low_threshold, :high_threshold, :name])
    |> validate_inclusion(:low_threshold, 0..100)
    |> validate_inclusion(:high_threshold, 0..100)
    |> check_constraint(:low_threshold, name: :check_thresholds)
  end
end
