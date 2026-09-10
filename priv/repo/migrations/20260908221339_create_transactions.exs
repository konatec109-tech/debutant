defmodule Learning.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer, null: false
      add :status, :string, null: false

      add :sender_id, references(:accounts, on_delete: :delete_all), null: false
      add :receiver_id, references(:accounts, on_delete: :delete_all), null: false
      timestamps()
    end

    create index(:transactions, [:sender_id])
    create index(:transactions, [:receiver_id])

  end
end
