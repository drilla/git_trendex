defmodule GitTrendex.App.Cli do
  def main(argv) do
    case OptionParser.parse!(argv, switches: [sync: :boolean]) do
      {[sync: true], _} -> :rpc.call(:"main@localhost", GitTrendex.App.Api, :sync, []) |> IO.inspect()
      {[all: true], _} -> GitTrendex.App.Api.get_all() |> IO.inspect()
      {[name: name], _} -> GitTrendex.App.Api.get_repo(name) |> IO.inspect
      {[id: id], _} ->
        id
        |> String.to_integer()
        |> GitTrendex.App.Api.get_repo()
        |> IO.inspect

    end
  end
end
