defmodule GitTrendex.App.Api do
  alias GitTrendex.Pact
  alias GitTrendex.Db.Repository
  alias GitTrendex.Github.ApiInterface
  alias GitTrendex.App.RepositoryModelAdapter
  alias GitTrendex.App.DbUpdater

  @spec get_repo(non_neg_integer | binary) :: Repository.t() | nil
  def get_repo(id) when is_integer(id) do
    Pact.repo().get(Repository, id)
  end

  def get_repo(name) when is_binary(name) do
    Pact.repo().get_by(Repository, name: name)
  end

  @spec get_all() :: [Repository.t()]
  def get_all() do
    Pact.repo().all(Repository)
  end

  @spec sync() :: :ok | ApiInterface.api_errors()
  def sync() do
    case Pact.github_api().fetch_trending() do
      {:ok, repos} ->
        repos
        |> Enum.map(&RepositoryModelAdapter.from_git!/1)
        |> Pact.repo().refresh_repos()

        DbUpdater.restart_timer()

        :ok
      {:error, reason} ->
        {:error, reason}
    end
  end
end
