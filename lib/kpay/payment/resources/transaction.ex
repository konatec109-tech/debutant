defmodule Kpay.Transaction do
  use Ash.Resource,
  domain: Kpay.Payment,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "kpay_transactions"
    repo Learning.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :amount, :integer, allow_nil?: false
    attribute :status, :atom, allow_nil?: false, default: :pending, constraints: [one_of: [:pending, :success, :failed]]

  end

  relationships do
    belongs_to :from_account, Kpay.Wallets.Account do
      allow_nil? false
      attribute_writable? true
    end

    belongs_to :to_account, Kpay.Wallets.Account do
      allow_nil? false
      attribute_writable? true
    end
  end

  actions do
    defaults [:read]
    create :transfer do
      argument :from_account_id, :uuid, allow_nil?: false
      argument :to_account_id, :uuid , allow_nil?: false
      argument :amount, :integer, allow_nil?: false
      change {Kpay.Operations.Transfer, []}
    end
  end

end
