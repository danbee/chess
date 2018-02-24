defmodule Chess.Repo.Migrations.AddTurnToGame do
  use Ecto.Migration

  def change do
    alter table("games") do
      add :turn, :string, default: "white"
    end
  end
end
