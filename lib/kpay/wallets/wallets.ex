defmodule Kpay.Wallets do
  use Ash.Domain
  

  resources do
    resource Kpay.Wallets.Wallet
    resource Kpay.Wallets.Account
  end
end
