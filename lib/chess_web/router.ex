defmodule ChessWeb.Router do
  use ChessWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChessWeb do
    pipe_through :browser # Use the default browser stack

    get "/", GameController, :index
    resources "/games", GameController, only: [:create, :show, :delete]
  end

  # Other scopes may use custom stacks.
  scope "/api", ChessWeb do
    pipe_through :api

    resources "/games", Api.GameController, only: [:show, :update]
  end
end
