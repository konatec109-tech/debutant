defmodule MatchingTest do
  use ExUnit.Case
  import Account
  import Matching

  test "test matching in Elixir" do
    assert run(1, 3, 5) == :ok
  end

  test " test map matching in Elixir" do
    assert register_user() == {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}}
  end

  test "test credit function in Elixir" do
    user_info = %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}
    assert credit(user_info, 1000) == {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 51000}}
  end

  test "testin debit function in Elixir" do
    user_info = %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}
    assert debit(user_info, 49500) == {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 500}}

    assert debit(user_info, 100000) == {:error, "Insufficient funds. Your current balance is 50000."}
  end

  test " testing no changment in balance" do
    user = %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}
    refute debit(user, 100000) == {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}}
  end

end
