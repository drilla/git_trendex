defmodule GitTrendex.Db.Repo do
  use Ecto.Repo,
    otp_app: :git_trendex,
    adapter: Ecto.Adapters.Postgres

  @behaviour GitTrendex.Db.RepoInterface

  alias GitTrendex.Db.Repository
  alias GitTrendex.Db.EctoHelper

  import Ecto.Query

  @impl GitTrendex.Db.RepoInterface
  def refresh_repos(new_repos) do
    db_repos = all(Repository)

    transaction(fn ->
      insert_or_update_new(new_repos)
      delete_missing(new_repos, db_repos)
    end)

    :ok
  end

  defp insert_or_update_new(repos) do
    maps = EctoHelper.to_maps(repos)

    insert_all(Repository, maps, [on_conflict: :replace_all, conflict_target: :id]) |> IO.inspect()
  end

  defp delete_missing(new, current) do
    missing_ids = get_missing_ids(new, current)
    delete_all( from(r in Repository, where: r.id in ^missing_ids))
  end

  defp get_missing_ids(new_items, db_items) do
    new_ids = Enum.map(new_items, &Map.get(&1, :id))
    db_ids = Enum.map(db_items, &Map.get(&1, :id))

    db_ids -- new_ids
  end
end
