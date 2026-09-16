defmodule Kpay.Wallets do
  use Ash.Resource

  resources do
    resource Kpay.Wallets.Wallet
    resource Kpay.Wallets.Account
  end
end
