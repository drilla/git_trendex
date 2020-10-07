defmodule GitTrendex.Db.Repo do
  use Ecto.Repo,
    otp_app: :git_trendex,
    adapter: Ecto.Adapters.Postgres
end
