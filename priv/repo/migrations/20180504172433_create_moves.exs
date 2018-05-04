defmodule Chess.Repo.Migrations.CreateMoves do
  use Ecto.Migration

  def change do
    create table(:moves) do
      add :game_id, references(:games)
      add :from, :map
      add :to, :map
      add :piece, :map
      add :piece_captured, :map

      timestamps()
    end
  end
end
