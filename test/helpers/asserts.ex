defmodule Test.GitTrendex.Helpers.Asserts do
  def assert_ecto_struct_equals(one, two) do
    one_clear = drop_meta(one)
    two_clear = drop_meta(two)

    assert_type(one, two)
    and
    one_clear == two_clear
  end

  @spec assert_type(map | struct, map | struct) :: boolean()
  def assert_type(one, two) when is_struct(one) and is_struct(two) do
    case {Map.has_key?(one, :__struct__), Map.has_key?(two, :__struct__)} do
      {true, true}   -> one.__struct__ == two.__struct__
      {false, false} -> true
      _              -> false
    end
  end

  def assert_type(one, two) when is_map(one) and is_map(two), do: true
  def assert_type(one, two), do: false

  defp drop_meta(%{meta: _} = struct) do
    Map.delete(struct, :meta)
  end

  defp drop_meta(struct), do: struct
end
