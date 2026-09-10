defmodule Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :integer
    field :status, :string

    belongs_to :sender, Account, foreign_key: :sender_id
    belongs_to :receiver, Account, foreign_key: :receiver_id

    timestamps()
  end

  def changeset(transaction \\ %Transaction{}, attrs) do
    transaction
    |> cast(attrs, ([:amount, :status, :sender_id, :receiver_id]))
    |> validate_required([:amount, :status, :sender_id, :receiver_id])
    |> validate_inclusion(:status, ["success", "failed"])

  end
end
