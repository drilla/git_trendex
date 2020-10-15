defmodule Test.Mocks.Github.HttpClientError do
  def get(_) do
    {:error,
     %HTTPoison.Error{
       reason: "error"
     }}
  end
end
