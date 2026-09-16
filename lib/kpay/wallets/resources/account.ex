defmodule Kpay.Wallets.Account do
  use Ash.Resource,
  domain: Kpay.Wallets,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "kpay_accounts"
    repo Learning.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string do
      allow_nil? false
    end
    attribute :phone, :string do
      allow_nil? true
      constraints [
        min_length: 10,
        max_length: 10,
        match: ~r/^[0-9]+$/
      ]
    end

    attribute :balance, :integer do
      allow_nil? false
      default 0
    end
  end

  relationships do
    belongs_to :wallet, Kpay.Wallets.Wallet do
      allow_nil? true
      allow_writable? true
    end

    belongs_to :bank_tenant, Kpay.Banking.BankTenant do
      allow_nil? true
      allow_writable? true
    end
  end

  actions do
    defaults [:read, :update]
    create :create do
      accept [:name, :phone, :wallet_id, :bank_tenant_id]
    end
    update :debit do
      argument :amount, :integer do
        allow_nil? false
      end

      validate compare(:balance, greater_than_or_equal_to: arg(:amount)) do
        message "insufficient fund for this operation"
      end

      change atomic_update(:balance, expr(balance - ^arg(:amount)))
    end

    update :credit do
      argument :amount, :integer do
       allow_nil? false
      end

      change atomic_update(:balance, expr(balance + ^arg(:amount)))
    end
  end

end
