defmodule Babukay.Venue do
  use Babukay.Web, :model

  schema "venues" do
    field :name, :string

    has_one :location_pairs, Babukay.LocationPair
    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_assoc(:location_pairs, require: true)
  end
end
