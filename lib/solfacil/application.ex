defmodule Solfacil.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Solfacil.Repo,
      # Start the Telemetry supervisor
      SolfacilWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Solfacil.PubSub},
      # Start Finch
      {Finch, name: MyFinch},
      # Start the Endpoint (http/https)
      SolfacilWeb.Endpoint,
      # Start a worker by calling: Solfacil.Worker.start_link(arg)
      # {Solfacil.Worker, arg}
      {Oban, oban_config()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Solfacil.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp oban_config do
    Application.fetch_env!(:solfacil, Oban)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SolfacilWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
