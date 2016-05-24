defmodule Babukay.VenueController do
  use Babukay.Web, :controller

  alias Babukay.Venue

  plug :scrub_params, "venue" when action in [:create, :update]

  def index(conn, _params) do
    venues = Repo.all(Venue)
    render(conn, "index.json", venues: venues)
  end

  def create(conn, %{"venue" => venue_params}) do
    changeset = Venue.changeset(%Venue{}, venue_params)

    case Repo.insert(changeset) do
      {:ok, venue} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", venue_path(conn, :show, venue))
        |> render("show.json", venue: venue)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Babukay.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    venue = Repo.get!(Venue, id)
    render(conn, "show.json", venue: venue)
  end

  def update(conn, %{"id" => id, "venue" => venue_params}) do
    venue = Repo.get!(Venue, id)
    changeset = Venue.changeset(venue, venue_params)

    case Repo.update(changeset) do
      {:ok, venue} ->
        render(conn, "show.json", venue: venue)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Babukay.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    venue = Repo.get!(Venue, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(venue)

    send_resp(conn, :no_content, "")
  end
end
