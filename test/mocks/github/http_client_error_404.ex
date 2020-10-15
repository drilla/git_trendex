defmodule Test.Mocks.Github.HttpClientError404 do
  def get(_) do
    {:error,
     %HTTPoison.Response{
       body: "not found",
       status_code: 404
     }}
  end
end
