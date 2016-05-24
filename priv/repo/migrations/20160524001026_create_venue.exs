defmodule Babukay.Repo.Migrations.CreateVenue do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add :name, :string
      add :lat, :string
      add :long, :string

      timestamps
    end

  end
end
