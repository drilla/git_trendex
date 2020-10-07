defmodule Test.GitTrendex.App.ApiTest do
  alias GitTrendex.App.Api
  alias GitTrendex.Db.Repository

  use GitTrendex.DataCase

  import Test.GitTrendex.Helpers.Db
  import Test.GitTrendex.Helpers.Asserts

  describe "get repo success" do
    setup do
      name = "test"
      id = 123
      model = add_repo(name, id)

      %{model: model}
    end

    test "get by name ok", %{model: model} do
      assert_ecto_struct_equals(Api.get_repo(model.name), model)
    end

    test "get by id ok", %{model: model} do
      assert_ecto_struct_equals(Api.get_repo(model.id), model)
    end

    test "get by name: none" do
      assert Api.get_repo("fake") == nil
    end

    test "get by id: none" do
      assert Api.get_repo(0) == nil
    end
  end

  describe "get all success" do
    setup do
      list = [
        add_repo("N1", 1),
        add_repo("N2", 2),
        add_repo("N3", 3)
      ]

      %{list: list}
    end

    test "get all ok", %{list: list} do
      assert Enum.count(Api.get_all()) == Enum.count(list)
    end
  end
end
