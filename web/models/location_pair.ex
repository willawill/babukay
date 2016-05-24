defmodule Babukay.LocationPair do
  use Babukay.Web, :model

  schema "location_pairs" do
    field :lat, :string
    field :long, :string
    belongs_to :venue, Babukay.Venue

    timestamps
  end

  @required_fields ~w(lat long)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
