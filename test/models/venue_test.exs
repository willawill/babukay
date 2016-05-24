defmodule Babukay.VenueTest do
  use Babukay.ModelCase

  alias Babukay.Venue

  @valid_attrs %{lat: "some content", long: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Venue.changeset(%Venue{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Venue.changeset(%Venue{}, @invalid_attrs)
    refute changeset.valid?
  end
end
