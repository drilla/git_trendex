defmodule GitTrendex.Db.EctoHelper do
  @spec to_maps([struct]) :: [map]
  def to_maps(schemas) do
    Enum.map(schemas, &to_map/1)
  end

  @spec to_map(struct) :: map
  def to_map(schema) do
    schema
  |> Map.from_struct()
  |> Map.delete(:__meta__)
  end
end
