defmodule GitTrendex.Pact do
  @moduledoc """
    DEPENDENCY INJECTION MODULE
  """

  use Pact

  @defaults [
    app_api: GitTrendex.App.Api,
    http: HTTPoison,
    repo: GitTrendex.Db.Repo,
    github_api: GitTrendex.Github.Api
  ]

  register(:app_api, Keyword.get(@defaults, :app_api))
  register(:http,  Keyword.get(@defaults, :http))
  register(:repo,  Keyword.get(@defaults, :repo))
  register(:github_api, Keyword.get(@defaults, :github_api))

  def app_api(), do: GitTrendex.Pact.get(:app_api)

  def repo(), do: GitTrendex.Pact.get(:repo)

  def http_client(), do: GitTrendex.Pact.get(:http)

  def github_api(), do: GitTrendex.Pact.get(:github_api)


  @doc """
    registering back a default service
  """
  @spec register_default(atom) :: :ok
  def register_default(service) when is_atom(service) do
    module = Keyword.get(@defaults, service)
    GitTrendex.Pact.register(service, module)
  end

  def child_spec() do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [], name: __MODULE__}
    }
  end

  def start_link(_args) do
    start_link()
  end
end
