defmodule Test.GitTrendex.App.DbUpdaterTest do
  alias GitTrendex.App.Api, as: AppApi
  alias GitTrendex.Db.Repository
  alias GitTrendex.Pact
  alias GitTrendex.Github.RepositoryModel, as: GitRepository
  alias GitTrendex.App.DbUpdater
  alias Test.GitTrendex.Mocks.App.ApiSync

  use ExUnit.Case, async: false

  import Test.GitTrendex.Helpers.Db
  import Test.GitTrendex.Helpers.Asserts

  describe "starting server and check regular updates is going" do
    setup do
      Pact.register(:app_api, ApiSync)

      start_supervised!({DbUpdater, timeout: 500})

      on_exit(fn -> Pact.register(:app_api, AppApi) end)
      :ok
    end

    test "init with timeout is ok" do
      last_updated = DbUpdater.get_last_updated_time()

      # wait for process to receive update once
      Process.sleep(750)

      new_last_updated = DbUpdater.get_last_updated_time()

      refute last_updated == new_last_updated
    end
  end
end
