defmodule GitTrendex.App.Api do
  @spec get_repo(integer | binary) :: map | nil
  def get_repo(id) when is_integer(id) do
    %{}
  end

  def get_repo(name) when is_binary(name) do
    %{}
  end

  @spec get_all() :: [map]
  def get_all() do
    [%{}]
  end

  @spec sync() :: :ok
  def sync() do
    :ok
  end

end
