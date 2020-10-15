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
    Pact.replace :http, Test.Mocks.Github.HttpClientError404 do
      assert {:error, :api_error} = Api.fetch_trending()
    end
  end


  test "api error" do
    Pact.replace :http, Test.Mocks.Github.HttpClientErrorApi do
      assert {:error, :api_error} = Api.fetch_trending()
    end
  end


  test "error" do
    Pact.replace :http, Test.Mocks.Github.HttpClientError do
      assert {:error, :other} = Api.fetch_trending()
    end
  end

end
