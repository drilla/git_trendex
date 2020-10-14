defmodule GitTrendex.Github.RepositoryModel do
  @moduledoc """
  данные репозитория гитхаб
  """

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          name: binary,
          owner: binary,
          desc: binary,
          stars: non_neg_integer(),
          stars_today: non_neg_integer()
        }

  defstruct [:id, :name, :owner, :desc, :stars, :stars_today]
end
