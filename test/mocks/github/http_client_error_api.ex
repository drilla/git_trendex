defmodule Test.Mocks.Github.HttpClientErrorApi do
  def get(_) do
    {:error,
     %HTTPoison.Error{
       reason: "error"
     }}
  end
end
