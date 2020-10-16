
GitTrendex.Pact.start_link()

integration? = ExUnit.configuration() |> Keyword.get(:include) |> Keyword.has_key?(:integration)

if integration? do
  IO.puts("Skipping unit test since integration tests will be running.")
  ExUnit.start()
  Ecto.Adapters.SQL.Sandbox.mode(GitTrendex.Db.Repo, :manual)
else
  Application.ensure_started(GitTrendex.Pact)
  # Application.ensure_all_started(:git_trendex)
  ExUnit.start()
end
