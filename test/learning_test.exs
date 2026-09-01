defmodule LearningTest do
  use ExUnit.Case
  import Learning

  test "greets the world" do
    assert hello() == :world
  end
  test "does not greet the world" do
    refute hello() == :hello
  end
end
