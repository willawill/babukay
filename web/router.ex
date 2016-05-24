defmodule Babukay.Router do
  use Babukay.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", Babukay do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", Babukay do
    pipe_through :api

    resources "/venues", VenueController, except: [:new, :edit]
  end
end
