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

    get "/", PageController, :index
    resources "/games", GameController, only: [:index, :create, :show, :delete]
    resources "/session", SessionController, only: [:new, :create], singleton: true
    resources "/registration", RegistrationController, only: [:new, :create], singleton: true
  end

  # Other scopes may use custom stacks.
  scope "/api", ChessWeb do
    pipe_through :api

    resources "/games", Api.GameController, only: [:show, :update]
  end
end
