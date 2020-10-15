defmodule Test.Mocks.Github.HttpClientOk do
  def get(_) do
    body = File.read!(__DIR__ <> "/trending_mock.html")

    {:ok,
     %HTTPoison.Response{
       body: body,
       status_code: 200
     }}
  end
end
