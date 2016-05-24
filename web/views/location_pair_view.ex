defmodule Babukay.LocationPairView do
  use Babukay.Web, :view

  def render("index.json", %{location_pairs: location_pairs}) do
    %{data: render_many(location_pairs, Babukay.LocationPairView, "location_pair.json")}
  end

  def render("show.json", %{location_pair: location_pair}) do
    %{data: render_one(location_pair, Babukay.LocationPairView, "location_pair.json")}
  end

  def render("location_pair.json", %{location_pair: location_pair}) do
    %{id: location_pair.id,
      lat: location_pair.lat,
      long: location_pair.long,
      venue_id: location_pair.venue_id}
  end
end
