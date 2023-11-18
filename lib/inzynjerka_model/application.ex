defmodule InzynjerkaModel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias InzynjerkaModel.Chatbot


  @impl true
  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: InzynjerkaModel.Supervisor]

    children = [
      InzynjerkaModel.Repo,
    ]

    Supervisor.start_link(children, opts)

    model_name = "sdadas/mmlw-retrieval-e5-large"
    {:ok, model_info} = Bumblebee.load_model({:hf, model_name})
    {:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, model_name})

    serving = Chatbot.qa_model(model_info, tokenizer, model_name)

    Supervisor.stop(InzynjerkaModel.Supervisor)

    children = [
      # Start the Telemetry supervisor
      InzynjerkaModelWeb.Telemetry,
      # Start the Ecto repository
      InzynjerkaModel.Repo,
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
