defmodule Test.GitTrendex.App.RepoTest do
  alias GitTrendex.Db.Repository
  alias GitTrendex.Pact
  alias GitTrendex.Db.Repo

  require GitTrendex.Pact

  use GitTrendex.DataCase, async: false

  import Test.GitTrendex.Helpers.Db
  import Test.GitTrendex.Helpers.Asserts

  describe "refresh db" do
    setup do
      # in db repos
      db_repos = [
      add_repo(%Repository{id: 1, name: "test", stars: 1}),
      add_repo(%Repository{id: 10, name: "test10", stars: 10})
      ]

      new_repos = [
        %Repository{id: 10, name: "test10",  stars: 10},
        %Repository{id: 15, name: "test15",  stars: 15}
      ]
      %{db_repos: db_repos, new_repos: new_repos}
    end

    test "ok", %{db_repos: db_repos, new_repos: new_repos} do

      assert Repo.refresh_repos(new_repos) == :ok

      after_sync = Repo.all(Repository)

      refute ecto_lists_equals(db_repos, after_sync)

      assert ecto_lists_equals(after_sync, new_repos)
    end

    test "failure, any illegal params", %{db_repos: db_repos, new_repos: new_repos} do
      assert Repo.refresh_repos([:err]) == :error
    end
  end
end
