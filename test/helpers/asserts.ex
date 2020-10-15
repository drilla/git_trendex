defmodule Test.GitTrendex.Helpers.Asserts do

  def assert_ecto_struct_equals(one, two) do
    one_clear = drop_meta(one)
    two_clear = drop_meta(two)

    assert_type(one, two) and
      one_clear == two_clear
  end

  @spec ecto_lists_equals([struct], [struct], atom) :: boolean
  def ecto_lists_equals(one, two, sort_key \\ :id) do
    one_sorted =
      one
      |> Enum.sort_by(&Map.get(&1, sort_key))
      |> Enum.map(&drop_meta/1)

    two_sorted =
      two
      |> Enum.sort_by(&Map.get(&1, sort_key))
      |> Enum.map(&drop_meta/1)

    one_sorted == two_sorted
  end

  @spec all_of_type?([struct], atom) :: boolean
  def all_of_type?(list, struct_module) do
    Enum.all?(list, fn %{__struct__: type} -> type == struct_module end)
  end

  @spec assert_type(map | struct, map | struct) :: boolean()
  def assert_type(one, two) when is_struct(one) and is_struct(two) do
    case {Map.has_key?(one, :__struct__), Map.has_key?(two, :__struct__)} do
      {true, true} -> one.__struct__ == two.__struct__
      {false, false} -> true
      _ -> false
    end
  end

  def assert_type(one, two) when is_map(one) and is_map(two), do: true
  def assert_type(_, _), do: false

  def drop_meta(%{__meta__: _} = struct) do
    Map.delete(struct, :__meta__)
  end

  def drop_meta(struct), do: struct
end
