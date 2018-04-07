defmodule Chess.Repo.Migrations.AddStateToGame do
  use Ecto.Migration

  def change do
    alter table("games") do
      add :state, :string
    end
  end
end
