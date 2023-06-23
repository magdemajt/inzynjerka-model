defmodule InzynjerkaModel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    {:ok, model_info} = Bumblebee.load_model({:hf, "Voicelab/sbert-large-cased-pl"})
    {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "Voicelab/sbert-large-cased-pl"})

    serving = Bumblebee.serve(model_info, tokenizer) # TODO fix this stupid s**t

    children = [
      # Start the Telemetry supervisor
      InzynjerkaModelWeb.Telemetry,
      # Start the Ecto repository
#      InzynjerkaModel.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InzynjerkaModel.PubSub},
      # Start Finch
      {Finch, name: InzynjerkaModel.Finch},
      # Start the Endpoint (http/https)
      InzynjerkaModelWeb.Endpoint,
      # Start a worker by calling: InzynjerkaModel.Worker.start_link(arg)
      {Nx.Serving, serving: serving, name: ChatApi.Serving, batch_timeout: 100},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InzynjerkaModel.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InzynjerkaModelWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
