defmodule Kpay.Banking do
  use Ash.Domain

  resources do
    resource Kpay.Banking.BankTenant
    resource Kpay.Banking.Bank
  end
end
