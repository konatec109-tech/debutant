defmodule Kpay.Banking.BankTenant do
  use Ash.Resource,
  domain: Kpay.Banking,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "kpay_bank_tenants"
    repo Learning.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :slug, :string, allow_nil?: false
    attribute :status, :atom, allow_nil?: false, default: :active, constraints: [one_of: [:active, :suspended]]
  end

  relationships do
    belongs_to :bank, Kpay.Banking.Bank do
      allow_nil? false
      attribute_writable? true
    end
  end

  identities do
    identity :unique_slug, [:slug]
  end

  actions do
    defaults [:read, :update]
    create :create do
      accept [:slug, :bank_id]
    end
  end
end
