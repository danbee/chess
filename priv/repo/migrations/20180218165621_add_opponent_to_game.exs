defmodule Chess.Repo.Migrations.AddOpponentToGame do
  use Ecto.Migration

  def change do
    alter table("games") do
      add :opponent_id, references(:users)
    end
  end
end
