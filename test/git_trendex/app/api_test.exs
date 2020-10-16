defmodule Test.GitTrendex.App.ApiTest do
  alias GitTrendex.App.Api
  alias GitTrendex.Db.Repository
  alias GitTrendex.Pact
  alias GitTrendex.Github.RepositoryModel, as: GitRepository

  alias Test.GitTrendex.Mocks.Github.ApiError
  alias Test.GitTrendex.Mocks.Github.ApiOk
  alias Test.GitTrendex.Mocks.Db.RepoOk

  require GitTrendex.Pact

  use GitTrendex.DataCase, async: false
  @moduletag :integration

  import Test.GitTrendex.Helpers.Db
  import Test.GitTrendex.Helpers.Asserts

  describe "get repo success using db" do
    setup do
      model = add_repo("test", 123)

      %{model: model}
    end

    test "get by name ok", %{model: model} do
      assert_ecto_struct_equals(Api.get_repo(model.name), model)
    end

    test "get by id ok", %{model: model} do
      assert_ecto_struct_equals(Api.get_repo(model.id), model)
    end

    test "get by name: none" do
      assert Api.get_repo("fake") == nil
    end

    test "get by id: none" do
      assert Api.get_repo(0) == nil
    end
  end

  describe "get all success using db" do
    setup do
      list = [
        add_repo("N1", 1),
        add_repo("N2", 2),
        add_repo("N3", 3)
      ]

      %{list: list}
    end

    test "get all ok", %{list: list} do
      assert Enum.count(Api.get_all()) == Enum.count(list)
    end
  end

  ## SYNCING

  describe "sync ok using stubs" do
    setup do
      on_exit(fn ->
        Pact.register(:github_api, GitTrendex.Github.Api)
        Pact.register(:repo, GitTrendex.Db.Repo)
      end)

      Pact.register(:github_api, ApiOk)
      Pact.register(:repo, RepoOk)
    end

    test "sync succes" do
      assert Api.sync() == :ok
    end
  end

  describe "sync ok using db" do
    setup do
      # in db repos
      add_repo(%Repository{id: 1, name: "test", stars: 1})
      add_repo(%Repository{id: 10, name: "test10", stars: 10})

      on_exit(fn ->
        Pact.register(:github_api, GitTrendex.Github.Api)
      end)

      fake_api =
        Pact.generate :github_api do
          def fetch_trending() do
            {:ok,
             [
               %GitTrendex.Github.RepositoryModel{id: 10, name: "test10", stars: 10},
               %GitTrendex.Github.RepositoryModel{id: 15, name: "test15", stars: 15}
             ]}
          end
        end

      Pact.register(:github_api, fake_api)

      :ok
    end

    test "sync succes with db" do
      before_sync = Api.get_all()

      assert Api.sync() == :ok

      after_sync = Api.get_all()

      refute ecto_lists_equals(before_sync, after_sync)

      expected_sync = [
        %Repository{id: 10, name: "test10", stars: 10},
        %Repository{id: 15, name: "test15", stars: 15}
      ]

      assert ecto_lists_equals(after_sync, expected_sync)
    end
  end

  describe "sync fail by api" do
    setup do
      Pact.register(:github_api, ApiError)
      %{}
    end

    test "sync failure api" do
      assert Api.sync() == {:error, :api_error}
    end

    test "sync failure other" do
      error_other =
        Pact.generate :github_api do
          def fetch_trending() do
            {:error, :other}
          end
        end

      Pact.replace :github_api, error_other do
        assert Api.sync() == {:error, :other}
      end
    end
  end
end
