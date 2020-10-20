defmodule GitTrendex.Db.Repository do
  @derive {Jason.Encoder, only: [:id, :name, :owner, :desc, :stars, :stars_today]}
  use Ecto.Schema
  @primary_key {:id, :integer, autogenerate: false}

  schema "repos" do
    field(:name, :string)
    field(:owner, :string)
    field(:desc, :string, size: 2048)
    field(:stars, :integer)
    field(:stars_today, :integer)
  end

  @type t :: %{
          id: integer,
          name: binary,
          owner: binary,
          desc: binary,
          stars: integer,
          stars_today: integer
        }
end
