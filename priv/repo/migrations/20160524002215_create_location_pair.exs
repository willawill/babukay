defmodule Babukay.Repo.Migrations.CreateLocationPair do
  use Ecto.Migration

  def change do
    create table(:location_pairs) do
      add :lat, :string
      add :long, :string
      add :venue_id, references(:venues, on_delete: :nothing)

      timestamps
    end
    create index(:location_pairs, [:venue_id])

  end
end
