defmodule Chess.Repo.Migrations.CreateMoves do
  use Ecto.Migration

  def change do
    create table(:moves) do
      add :game_id, references(:games, on_delete: :delete_all)
      add :from, :map, null: false
      add :to, :map, null: false
      add :piece, :map, null: false
      add :piece_captured, :map

      timestamps()
    end

    create index(:moves, [:game_id])
  end
end
