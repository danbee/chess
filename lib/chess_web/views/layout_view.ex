defmodule ChessWeb.LayoutView do
  use ChessWeb, :view

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
