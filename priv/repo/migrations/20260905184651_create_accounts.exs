defmodule Learning.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :phone, :string
      add :balance_atomic, :integer
      timestamps()
    end

  end
end
