defmodule GitTrendex.App.Cli do
  def main(argv) do
    case OptionParser.parse!(argv, switches: [sync: :boolean]) do
      {[sync: true], _} ->
        :rpc.call(:main@localhost, GitTrendex.App.Api, :sync, []) |> IO.puts()

      {[all: true], _} ->
        :rpc.call(:main@localhost, GitTrendex.App.Api, :get_all, []) |> output()

      {[name: name], _} ->
        :rpc.call(:main@localhost, GitTrendex.App.Api, :get_repo, [name]) |> output()

      {[id: id], _} ->
        id_int = String.to_integer(id)

        :rpc.call(:main@localhost, GitTrendex.App.Api, :get_repo, [id_int])
        |> output()

      _ ->
        help() |> IO.puts()
    end
  end

  def help() do
    """
    usage
    ./gittrendex

    NO ARGS - show usage

     --all - get all trending repos

     --sync - update repos with github trending

     --name 123  - get repo by name

     --id 123  - get repo by id
    """
  end

  defp output(repos) when is_list(repos) do
    repos
    |> Enum.map(&to_map(&1))
    |> IO.inspect()
  end

  defp output(repo), do: output([repo])

  defp to_map(repo) do
    repo
    |> Map.from_struct()
    |> Map.drop([:__meta__])
  end
end
