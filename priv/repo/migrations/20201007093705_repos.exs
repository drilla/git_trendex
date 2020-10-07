defmodule GitTrendex.Db.Repo.Migrations.Repos do
  use Ecto.Migration

  def change do
    create table("repos", primary_key: false) do
      add :id,    :integer, primary_key: true
      add :name,  :string, size: 64
      add :url,   :string
      add :stars, :integer
    end
  end
end
