defmodule GitTrendex.Db.RepoInterface do
  alias GitTrendex.Db.Repository
  @callback refresh_repos([Repository.t()]) :: :ok | :error
end
