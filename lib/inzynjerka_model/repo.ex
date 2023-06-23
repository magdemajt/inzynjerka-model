defmodule InzynjerkaModel.Repo do
  use Ecto.Repo,
    otp_app: :inzynjerka_model,
    adapter: Ecto.Adapters.Postgres
end
