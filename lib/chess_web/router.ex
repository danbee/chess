defmodule ChessWeb.Router do
  use ChessWeb, :router

  alias Phoenix.Token

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug Chess.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
    plug :put_user_token
  end

  pipeline :api do
    plug :fetch_session
    plug :accepts, ["json"]
  end

  scope "/", ChessWeb do
    pipe_through [:browser, :auth] # Use the default browser stack

    get "/", PageController, :index
    resources "/session", SessionController,
      only: [:new, :create, :delete], singleton: true
    resources "/registration", RegistrationController,
      only: [:new, :create], singleton: true
  end

  scope "/", ChessWeb do
    pipe_through [:browser, :auth, :ensure_auth]

    resources "/games", GameController,
      only: [:index, :new, :create, :show, :delete]
  end

  # Other scopes may use custom stacks.
  scope "/api", as: :api do
    pipe_through [:api, :auth, :ensure_auth]

    resources "/games", ChessWeb.Api.GameController, only: [:show, :update]
  end

  defp put_user_token(conn, _) do
    if current_user = Guardian.Plug.current_resource(conn) do
      token = Token.sign(conn, "game socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end
end
