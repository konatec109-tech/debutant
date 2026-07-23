defmodule MatchingTest do
  use ExUnit.Case
  import Matching

  test "test matching in Elixir" do
    assert run(1, 3, 5) == :ok
  end

  test " test map matching in Elixir" do
    assert register_user() == {:success, %{name: "ibrahim", age: 25, phone: "0704102697", balance_atomic: 50000}}
  end
end
