defmodule Kpay.Payment do
  use Ash.Domain

  resources do
    resource Kpay.Account
    resource Kpay.Transaction
  end
end
