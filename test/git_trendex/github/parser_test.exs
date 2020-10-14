defmodule Test.GitTrendex.Github.ParserTest do
  alias GitTrendex.Pact
alias GitTrendex.Github.Parser
  require GitTrendex.Pact

  use ExUnit.Case



  describe "parsing" do
    setup do
      url = Application.get_env(:git_trendex, :trending_url)
      {:ok, %HTTPoison.Response{body: document}} = HTTPoison.get(url)
      %{document: document}
    end

    test "ok", %{document: doc} do
      assert {:ok, repos} = Parser.parse_document(doc)

      assert is_list(repos)
      assert Enum.count(repos) > 0
    end

  end
    test "failure, illegal content" do
      assert Parser.parse_document("xxxxx") == :error
    end
end
