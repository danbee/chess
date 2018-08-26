defmodule ChessWeb.UserSocketTest do
  use ChessWeb.ChannelCase, async: true

  alias ChessWeb.UserSocket

  test "authenticate with valid token" do
    token = Phoenix.Token.sign(@endpoint, "game socket", 42)

    assert {:ok, socket} = connect(UserSocket, %{"token" => token})
    assert socket.assigns.user_id == 42
  end

  test "cannot authenticate with invalid token" do
    assert :error = connect(UserSocket, %{"token" => "invalid-token"})
  end

  test "cannot authenticate with no token" do
    assert :error = connect(UserSocket, %{})
  end
end
