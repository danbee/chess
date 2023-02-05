defmodule ChessWeb.Router do
  use ChessWeb, :router

  alias Phoenix.Token

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :auth do
    plug(Chess.Auth.Pipeline)
  end

  pipeline :ensure_auth do
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(:put_user_token)
  end

  pipeline :api do
    plug(:fetch_session)
    plug(:accepts, ["json"])
  end

  scope "/", ChessWeb do
    # Use the default browser stack
    pipe_through([:browser, :auth])

    get("/", PageController, :index)
    resources("/session", SessionController, only: [:new, :create, :delete], singleton: true)
    resources("/registration", RegistrationController, only: [:new, :create], singleton: true)
  end

  scope "/", ChessWeb do
    pipe_through([:browser, :auth, :ensure_auth])

    resources("/games", GameController, only: [:index, :new, :create, :show, :delete])
    resources("/profile", ProfileController, only: [:edit, :update], singleton: true)
    resources("/password", PasswordController, only: [:edit, :update], singleton: true)
  end

  # Other scopes may use custom stacks.
  scope "/api", as: :api do
    pipe_through([:api, :auth, :ensure_auth])

    resources("/opponents", ChessWeb.Api.OpponentsController, only: [:index])
  end

  if Mix.env() == :dev do
    forward("/sent_emails", Bamboo.SentEmailViewerPlug)
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
