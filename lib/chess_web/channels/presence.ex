defmodule ChessWeb.Presence do
  use Phoenix.Presence,
    otp_app: :chess,
    pubsub_server: Chess.PubSub
end
