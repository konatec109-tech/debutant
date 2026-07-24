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
    user_info = {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}}
    assert credit(user_info, 1000) == {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 51000}}

  end

  test "testin debit function in Elixir" do
    user_info = {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}}
    assert debit(user_info, 49500) == {:success, %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 500}}
  end
end
