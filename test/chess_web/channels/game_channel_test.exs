defmodule ChessWeb.GameChannelTest do
  use ChessWeb.ChannelCase

  alias ChessWeb.UserSocket

  import Chess.Factory
  # import Chess.AuthenticationHelpers

  test "assigns game_id to the socket after join" do
    user = insert(:user)

    game =
      insert(:game, %{
        user_id: user.id,
        opponent_id: insert(:opponent).id
      })

    token = Phoenix.Token.sign(@endpoint, "game socket", user.id)
    {:ok, socket} = connect(UserSocket, %{"token" => token})

    {:ok, _, socket} = subscribe_and_join(socket, "game:#{game.id}", %{})

    assert socket.assigns.game_id == Integer.to_string(game.id)
  end

  test "returns the game state after join" do
    user = insert(:user)
    opponent = insert(:opponent, %{name: "Daruk"})

    game =
      insert(:game, %{
        user_id: user.id,
        opponent_id: opponent.id
      })

    token = Phoenix.Token.sign(@endpoint, "game socket", user.id)
    {:ok, socket} = connect(UserSocket, %{"token" => token})

    {:ok, _, _} = subscribe_and_join(socket, "game:#{game.id}", %{})

    assert_push("game:update", %{
      player: "white",
      opponent: "Daruk",
      turn: "white"
    })
  end
end
