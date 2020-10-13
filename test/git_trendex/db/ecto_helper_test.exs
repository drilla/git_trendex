defmodule Test.GitTrendex.Db.EctoHelperTest do
  use ExUnit.Case
  alias Test.GitTrendex.Mocks.Db.EctoSchema

  alias GitTrendex.Db.EctoHelper

  test "one" do
    before = %EctoSchema{test: "test", __meta__: 1}
    result = EctoHelper.to_map(before)

    refute is_struct(result)
    assert %{test: "test"} == result
  end

  test "list" do
    before = [
      %EctoSchema{test: "test", __meta__: 1},
      %EctoSchema{test: "test", __meta__: 1}
    ]

    result = EctoHelper.to_maps(before)

    Enum.each(result, fn item ->
      refute is_struct(item)
      assert %{test: "test"} == item
    end)
  end
end
