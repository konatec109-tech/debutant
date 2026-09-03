defmodule WalletServerTest do
  use ExUnit.Case
  import WalletServer

  test "test get balance"do
    user_test = %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}

    pid = start_supervised!({WalletServer, user_test})
    solde = get_balance(pid)
    assert  solde == 50000
  end
end
