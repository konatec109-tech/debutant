defmodule ShoutTest do
 use ExUnit.Case
 import Shout
 test "uppercase function" do
  assert Shout.uppercase("rodriguez") == "RODRIGUEZ\nhello rodriguez"
 end
 hello("ibrahim")
end
