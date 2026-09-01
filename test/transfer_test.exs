defmodule TransferTest do
  use ExUnit.Case
  import Send

  test "successful transfer" do
    from = %{id: 1, name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}
    to = %{id: 2, name: "ahmed", age: 25, phone: "0704102698", balance_atomic: 30000}
    amount = 10000

    assert transfer(from, to, amount) == %{id: 1, type: :transfert, amount: 10000, from: 40000, to: 40000, status: :success}
  end
end
