defmodule Babukay.VenueView do
  use Babukay.Web, :view

  def render("index.json", %{venues: venues}) do
    %{data: render_many(venues, Babukay.VenueView, "venue.json")}
  end

  def render("show.json", %{venue: venue}) do
    %{data: render_one(venue, Babukay.VenueView, "venue.json")}
  end

  def render("venue.json", %{venue: venue}) do
    %{id: venue.id,
      name: venue.name,
      lat: venue.lat,
      long: venue.long}
  end
end
