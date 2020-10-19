defmodule GitTrendex.App.UpdateTimeout do
  @spec timeout() :: non_neg_integer() | nil
  def timeout() do
    Application.get_env(:git_trendex, :refresh_rate_minutes)
    |> to_minutes()
  end

  defp to_minutes(nil), do: nil
  defp to_minutes(time) when is_integer(time) do
    Application.get_env(:git_trendex, :refresh_rate_minutes) * 1000 * 60
  end
end
