defmodule GitTrendex.Github.Api do
  @moduledoc """
    запрашиваем информацию у github
  """

  alias GitTrendex.Pact, as: Pact

  alias GitTrendex.Github.RepositoryModel
  alias GitTrendex.Github.ApiInterface

  require Logger

  @behaviour ApiInterface

  @api_url "https://ghapi.huchen.dev/repositories"

  @impl true
  def fetch_trending() do
    with {:ok, %HTTPoison.Response{body: body}} <-
           Pact.http_client().post(@api_url, %{since: "weekly"}, headers(), opts()),
         {:ok, data} <- Jason.decode(body),
         repos <- create_models(data) do
      {:ok, repos}
    else
      error -> recycle_error(error)
    end
  end

  #########
  # PRIVATE
  #########

  @spec recycle_error({:error, HTTPoison.Error.t()} | any()) :: ApiInterface.api_errors()
  defp recycle_error({:error, %HTTPoison.Error{} = error}) do
    Logger.error(inspect(error))
    {:error, :api_error}
  end

  defp recycle_error(error) do
    Logger.error(inspect(error))
    {:error, :other}
  end

  @spec create_models([map()]) :: [RepositoryModel.t()]
  defp create_models(repos) do
    result =
      Enum.map(repos, fn %{
                           id: id,
                           name: name,
                           url: url,
                           stars: stars
                         } ->
        %RepositoryModel{
          id: id,
          name: name,
          stars: stars,
          url: url
        }
      end)

    result
  end

  defp headers() do
    [
      {"Accept", "application/json"}
    ]
  end

  @spec opts() :: Keyword.t()
  defp opts() do
    [follow_redirect: true]
  end
end
