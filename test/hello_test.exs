defmodule HelloTest do
  use ExUnit.Case
  import Greet
   test "greets the name" do
    assert hello("ibrahim") == IO.puts "hello ibrahim"
   end

end
