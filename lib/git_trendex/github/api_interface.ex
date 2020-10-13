defmodule GitTrendex.Github.ApiInterface do
  alias GitTrendex.Github.RepositoryModel

  @callback fetch_trending() :: {:ok, [ReposioryModel.t()]} | {:error, :api_error | :other}

  @typedoc """
    api errors
  """
  @type api_errors :: {:error, :api_error | :other}
end
