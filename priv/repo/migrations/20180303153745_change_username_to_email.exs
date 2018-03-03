defmodule Chess.Repo.Migrations.ChangeUsernameToEmail do
  use Ecto.Migration

  def change do
    drop index(:users, [:username])
    rename(table("users"), :username, to: :email)
    create unique_index(:users, [:email])
  end
end
