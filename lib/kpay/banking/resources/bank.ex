defmodule Kpay.Banking.Bank do
  use Ash.Resource,
  domain: Kpay.Banking,
  data_layer: AshPostgres.DataLayer

  postgres do
    table "Kpay_banks"
    repo Learning.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :bic_code, :string, allow_nil?: false
    timestamps()
  end

  actions do
    defaults [:read, :create, :update]
  end
end
