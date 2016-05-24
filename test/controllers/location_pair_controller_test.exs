defmodule Babukay.LocationPairControllerTest do
  use Babukay.ConnCase

  alias Babukay.LocationPair
  @valid_attrs %{lat: "some content", long: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, location_pair_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    location_pair = Repo.insert! %LocationPair{}
    conn = get conn, location_pair_path(conn, :show, location_pair)
    assert json_response(conn, 200)["data"] == %{"id" => location_pair.id,
      "lat" => location_pair.lat,
      "long" => location_pair.long,
      "venue_id" => location_pair.venue_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, location_pair_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, location_pair_path(conn, :create), location_pair: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(LocationPair, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, location_pair_path(conn, :create), location_pair: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    location_pair = Repo.insert! %LocationPair{}
    conn = put conn, location_pair_path(conn, :update, location_pair), location_pair: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(LocationPair, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    location_pair = Repo.insert! %LocationPair{}
    conn = put conn, location_pair_path(conn, :update, location_pair), location_pair: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    location_pair = Repo.insert! %LocationPair{}
    conn = delete conn, location_pair_path(conn, :delete, location_pair)
    assert response(conn, 204)
    refute Repo.get(LocationPair, location_pair.id)
  end
end
