defmodule ChessWeb.LayoutView do
  use ChessWeb, :view

  import Chess.Auth, only: [current_user: 1]
end
