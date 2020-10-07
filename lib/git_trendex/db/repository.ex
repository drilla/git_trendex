defmodule GitTrendex.Db.Repository do
  use Ecto.Schema

  @primary_key {:id, :integer, autogenerate: false}

  schema "repos" do
    field(:name, :string)
    field(:url, :string)
    field(:stars, :integer)
  end

  @type t :: %{
          id: integer,
          name: binary,
          url: binary,
          stars: integer
        }
end
