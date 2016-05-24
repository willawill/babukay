defmodule Babukay.LocationPairTest do
  use Babukay.ModelCase

  alias Babukay.LocationPair

  @valid_attrs %{lat: "some content", long: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LocationPair.changeset(%LocationPair{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LocationPair.changeset(%LocationPair{}, @invalid_attrs)
    refute changeset.valid?
  end
end
