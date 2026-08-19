defmodule AliasTest do
  use ExUnit.Case
  import Maths

  test "test alias in Elixir" do
    assert alias_local("france") == IO.puts("FRANCE")
  end
end
