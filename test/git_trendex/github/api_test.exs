defmodule Test.GitTrendex.Github.ApiTest do
  use ExUnit.Case
  require GitTrendex.Pact
  import Test.GitTrendex.Helpers.Asserts

  alias GitTrendex.Pact
  alias GitTrendex.Github.Api
  alias GitTrendex.Github.RepositoryModel

  test "got response, success" do
    Pact.replace :http, Test.Mocks.Github.HttpClientOk do
      assert {:ok, repos} = Api.fetch_trending()
      assert all_of_type?(repos, RepositoryModel)
    end
  end

  test "got response, 404" do

  end


  test "error" do

  end

end
