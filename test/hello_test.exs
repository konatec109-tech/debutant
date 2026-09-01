defmodule HelloTest do
  use ExUnit.Case
  import Greet
   test "greets the name" do
    assert hello("ibrahim") == "hello ibrahim"
   end
   test "does not greet the name" do
    refute hello("ibrahim") == "welcome stephane"
   end

end
