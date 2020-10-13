defmodule Test.GitTrendex.Mocks.Db.RepoOk do
  @behaviour GitTrendex.Db.RepoInterface

  alias GitTrendex.Db.Repository

  def refresh_repos(_list) do
   :ok
  end

end
