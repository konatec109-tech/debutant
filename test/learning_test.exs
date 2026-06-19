defmodule LearningTest do
  use ExUnit.Case
  import Learning

  test "greets the world" do
    assert hello() == :world
  end
end
