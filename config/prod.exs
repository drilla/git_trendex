use Mix.Config

config :git_trendex, GitTrendexWeb.Endpoint,
  http: [port: 4000],
  url: [host: "localhost", port: 4000]
 #cache_static_manifest: "priv/static/cache_manifest.json"

config :git_trendex, GitTrendex.Db.Repo,
  database: "data",
  hostname: "db",
  show_sensitive_data_on_connection_error: false,
  pool_size: 100

# Do not print debug messages in production
config :logger, level: :info
