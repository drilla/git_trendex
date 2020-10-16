defmodule GitTrendex.Pact do

  @moduledoc """
    DEPENDENCY INJECTION MODULE
  """

  use Pact

  register(:app_api, GitTrendex.App.Api)
  register(:http, HTTPoison)
  register(:repo, GitTrendex.Db.Repo)
  register(:github_api, GitTrendex.Github.Api)

  def app_api(), do: GitTrendex.Pact.get(:app_api)

  def repo(), do: GitTrendex.Pact.get(:repo)

  def http_client(), do: GitTrendex.Pact.get(:http)

  def github_api(), do: GitTrendex.Pact.get(:github_api)

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
