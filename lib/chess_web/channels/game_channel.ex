defmodule ChessWeb.GameChannel do
  @moduledoc false

  use Phoenix.Channel

  def join("game:" <> game_id, _params, socket) do
    {:ok, socket}
  end
end
