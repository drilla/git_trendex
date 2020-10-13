defmodule GitTrendex.App.RepositoryModelAdapter do
  alias GitTrendex.Github.RepositoryModel, as: GitRepo
  alias GitTrendex.Db.Repository, as: DbRepo

  @spec from_git!(GitRepo.t()) :: DbRepo.t()
  def from_git!(%GitRepo{} = git_repo) do
    struct!(DbRepo, Map.to_list(git_repo) |> Keyword.delete(:__struct__))
  end
end
