defmodule GitTrendexWeb.PageController do
  use GitTrendexWeb, :controller
  alias GitTrendex.App.Api

  def index(conn, _params) do
    repos = Api.get_all()

    conn
    |> json(repos)
  end

  def show(conn, %{"id" => id}) do
    repo =
      id
      |> String.to_integer()
      |> Api.get_repo()

    conn
    |> json(repo)
  end

  def show(conn, %{"name" => name}) do
    repo =
      name
      |> Api.get_repo()

    conn
    |> json(repo)
  end

  def sync(conn, _params) do
    result = Api.sync()

    case result do
      :ok -> json(conn, result)

      {:error, :api_error} ->
        conn
        |> put_status(503)
        |> json("api not working")
    end
  end
end
