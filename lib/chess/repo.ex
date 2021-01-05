defmodule Chess.Repo do
  use Ecto.Repo, otp_app: :chess, adapter: Ecto.Adapters.Postgres
end
