defmodule GitTrendex.Github.Api do
  @moduledoc """
    запрашиваем информацию у github
  """

  alias GitTrendex.Pact, as: Pact

  alias GitTrendex.Github.ApiInterface
  alias GitTrendex.Github.Parser
  require Logger

  @behaviour ApiInterface

  @url Application.get_env(:git_trendex, :trending_url)

  @impl true
  def fetch_trending() do
    with {:ok, %HTTPoison.Response{body: body}} <-
           Pact.http_client().get(@url),
         {:ok, repos} <- Parser.parse_document(body) do
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

  defp recycle_error({:error, %HTTPoison.Response{} = resp}) do
    Logger.error(inspect(resp))
    {:error, :api_error}
  end
  defp recycle_error(error) do
    Logger.error(inspect(error))
    {:error, :other}
  end
end
