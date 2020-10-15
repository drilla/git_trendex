defmodule GitTrendex.Github.Parser do
  @moduledoc """
     парсит страницу trending
  """

  alias GitTrendex.Github.RepositoryModel

  require Logger

  @spec parse_document(binary) :: {:ok, [RepositoryModel.t()]} | :error
  def parse_document(html) do
    case Floki.parse_document(html)  do
      {:ok, html_tree} ->
          html_tree
          |> Floki.find("main .Box article.Box-row")
          |> Enum.map(&parse_fragment/1)
          |> check_and_return()

      err ->
        Logger.error(inspect(err))
        :error
    end
  end

  #########
  # PRIVATE
  #########

  defp check_and_return([]), do: :error
  defp check_and_return(list) when is_list(list), do: {:ok, list}

  defp parse_fragment(fragment) do
    url =
      fragment
      |> Floki.attribute("h1 > a", "href")
      |> hd()

    [owner, repo] =
      url
      |> parse_href()

    desc =
      fragment
      |> Floki.find("article > p")
      |> Floki.text()
      |> String.trim()

    id =
      fragment
      |> Floki.attribute("h1 > a", "data-hydro-click")
      |> hd()
      |> Jason.decode!()
      |> Map.get("payload")
      |> Map.get("record_id")

    stars =
      fragment
      |> Floki.find("article > div:last-child > a:first-of-type")
      |> Floki.text()
      |> String.trim()
      |> String.replace(",", "")
      |> String.to_integer()

    stars_today =
      fragment
      |> Floki.find("article > div:last-child > span:last-of-type")
      |> Floki.text()
      |> String.trim()
      |> String.replace(",", "")
      |> Integer.parse()
      |> Tuple.to_list()
      |> hd()

    %RepositoryModel{
      id: id,
      name: repo,
      owner: owner,
      desc: desc,
      stars: stars,
      stars_today: stars_today
    }
  end

  defp parse_href(href) do
    href
    |> String.trim("/")
    |> String.split("/")
  end
end
