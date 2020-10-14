defmodule Test.GitTrendex.Mocks.Github.ApiOk do
  @behaviour GitTrendex.Github.ApiInterface
  alias GitTrendex.Github.RepositoryModel

  def fetch_trending() do
    {:ok, [%RepositoryModel{name: "test", id: 1, stars: 10}]}
  end
end
