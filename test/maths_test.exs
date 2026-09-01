defmodule AliasTest do
  use ExUnit.Case
  import Maths

  test "test alias in Elixir" do
    assert alias_local("france") == ("FRANCE\nhello france")
  end
  test "test refute alias in Elixir" do
    refute alias_local("france") == ("france")
  end
end
