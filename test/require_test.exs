defmodule RequireTest do
  import CheckInteger
  use ExUnit.Case

  test "require testing to verrify odds" do
    assert check_odd(3) == true
  end

end
