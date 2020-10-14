defmodule GitTrendex.Db.Repo.Migrations.Fields do
  use Ecto.Migration

  def change do
    alter table("repos") do
      add :owner,    :string
      add :desc,  :string, size: 2048
      add :stars_today, :integer

      remove :url
    end
  end
end
