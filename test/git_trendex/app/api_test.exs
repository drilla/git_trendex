defmodule Test.GitTrendex.App.ApiTest do
  alias GitTrendex.App.Api
  alias GitTrendex.Db.Repository

  use GitTrendex.DataCase

  import Test.Helpers.Db

  describe "get repo success" do
    setup do
      name = "test"
      id = 123
      add_repo(name, id)

      %{name: name, id: id}
    end

    test "get by name ok", %{name: name, id: id} do
      assert Api.get_repo(name) == %Repository{name: name, id: id}
    end

    test "get by id ok", %{name: name, id: id} do
      assert Api.get_repo(id) == %Repository{name: name, id: id}
    end

    test "get by name: none", %{name: name} do
      assert Api.get_repo("fake") == nil
    end

    test "get by id: none", %{id: id} do
      assert Api.get_repo(0) == nil
    end
  end


  describe "get all success" do
    setup do
     list = [
      add_repo("N1", 1),
      add_repo("N2", 2),
      add_repo("N3", 3),
      ]

      %{list: list}
    end

    test "get all ok", %{list: list} do
      assert Enum.count(Api.get_all()) == Enum.count(list)
    end
  end
end
