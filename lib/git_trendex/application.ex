defmodule GitTrendex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      GitTrendex.Pact,
      # Start the Ecto repository
      GitTrendex.Db.Repo,
      {GitTrendex.App.DbUpdater, timeout: GitTrendex.App.UpdateTimeout.timeout()},
      # Start the Telemetry supervisor
      GitTrendexWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GitTrendex.PubSub},
      # Start the Endpoint (http/https)
      GitTrendexWeb.Endpoint
      # Start a worker by calling: GitTrendex.Worker.start_link(arg)
      # {GitTrendex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GitTrendex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_timeout() do
    Application.get_env(:git_trendex, :refresh_rate_minutes)
    |> to_minutes()
  end

  def to_minutes(nil), do: nil
  def to_minutes(time) when is_integer(time) do
    Application.get_env(:git_trendex, :refresh_rate_minutes) * 1000 * 60
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GitTrendexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
