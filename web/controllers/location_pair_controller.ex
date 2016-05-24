defmodule Babukay.LocationPairController do
  use Babukay.Web, :controller

  alias Babukay.LocationPair

  plug :scrub_params, "location_pair" when action in [:create, :update]

  def index(conn, _params) do
    location_pairs = Repo.all(LocationPair)
    render(conn, "index.json", location_pairs: location_pairs)
  end

  def create(conn, %{"location_pair" => location_pair_params}) do
    changeset = LocationPair.changeset(%LocationPair{}, location_pair_params)

    case Repo.insert(changeset) do
      {:ok, location_pair} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", location_pair_path(conn, :show, location_pair))
        |> render("show.json", location_pair: location_pair)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Babukay.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    location_pair = Repo.get!(LocationPair, id)
    render(conn, "show.json", location_pair: location_pair)
  end

  def update(conn, %{"id" => id, "location_pair" => location_pair_params}) do
    location_pair = Repo.get!(LocationPair, id)
    changeset = LocationPair.changeset(location_pair, location_pair_params)

    case Repo.update(changeset) do
      {:ok, location_pair} ->
        render(conn, "show.json", location_pair: location_pair)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Babukay.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    location_pair = Repo.get!(LocationPair, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(location_pair)

    send_resp(conn, :no_content, "")
  end
end
