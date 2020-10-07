defmodule GitTrendex.App.Api do

  alias GitTrendex.Db.Repo
  alias GitTrendex.Db.Repository

  @spec get_repo(integer | binary) :: Repository.t() | nil
  def get_repo(id) when is_integer(id) do
     Repo.get(Repository, id)
  end

  def get_repo(name) when is_binary(name) do
    Repo.get_by(Repository, [name: name])
  end

  @spec get_all() :: [map]
  def get_all() do
    Repo.all(Repository)
  end

  @spec sync() :: :ok
  def sync() do
    :ok
  end

end
