defmodule Test.GitTrendex.Mocks.Github.ApiError do
  @behaviour GitTrendex.Github.ApiInterface

  def fetch_trending() do
    {:error, :api_error}
  end
end
