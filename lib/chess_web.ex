defmodule ChessWeb do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Chess.Web, :controller
      use Chess.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: ChessWeb
      import Phoenix.LiveView.Controller

      alias Chess.Repo
      import Ecto
      import Ecto.Query

      import ChessWeb.Router.Helpers
      import ChessWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/chess_web/templates",
        namespace: ChessWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, get_flash: 2, view_module: 1]
      import Phoenix.LiveView.Helpers

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Formulator

      import ChessWeb.Router.Helpers
      import ChessWeb.ErrorHelpers
      import ChessWeb.Gettext
    end
  end

  
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {ChessWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import ChessWeb.ErrorHelpers
      import ChessWeb.Gettext
      alias ChessWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Chess.Repo
      import Ecto
      import Ecto.Query
      import ChessWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
