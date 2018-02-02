defmodule Chess.Repo.Migrations.AddUniqueConstraintOnUsername do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:username])
  end
end
