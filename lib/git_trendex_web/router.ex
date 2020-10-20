defmodule GitTrendexWeb.Router do
  use GitTrendexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GitTrendexWeb do
    pipe_through :api

    get "/", PageController, :index
    get "/show", PageController, :show
    post "/sync", PageController, :sync
  end
end
