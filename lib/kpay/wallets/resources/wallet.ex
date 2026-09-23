defmodule Kpay.Wallets.Wallet do
  use Ash.Resource,
  domain:  Kpay.Wallets,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "kpay_wallets"
    repo Learning.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :currency, :atom, default: :XOF, constraints: [one_of: [:XOF, :EUR, :USD]]
    timestamps()
  end

  relationships do
    belongs_to :bank_tenant, Kpay.Banking.BankTenant do
      allow_nil? false
      attribute_writable? true
    end
    has_many :accounts, Kpay.Wallets.Account
  end



  actions do
    defaults [:read, :update]
    create :create_client_onboarding do
      argument :name, :string, allow_nil?: false
      argument :phone, :string, allow_nil?: false
      argument :bank_tenant_id, :uuid, allow_nil?: false

      change {Kpay.Wallets.Operations.OnboardClient, []}
    end
  end
end
