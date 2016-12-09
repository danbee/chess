defmodule Chess.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :board, :map

      timestamps()
    end

  end
end
