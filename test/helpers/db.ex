defmodule Test.GitTrendex.Helpers.Db do
  alias GitTrendex.Db.Repo
  alias GitTrendex.Db.Repository

  @spec add_repo(binary, non_neg_integer) :: Repository.t()
  def add_repo(name, id) do
    Repo.insert!(%Repository{name: name, id: id})
  end

  @spec add_repo(Repository.t()) :: Repository.t()
  def add_repo(%Repository{} = repo) do
    Repo.insert!(repo)
  end
end
