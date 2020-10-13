defmodule GitTrendex.Github.RepositoryModel do
  @moduledoc """
  данные репозитория гитхаб
  """

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          name: binary,
          url: binary,
          stars: non_neg_integer()
        }

  defstruct [:id, :name, :url, :stars]
end
