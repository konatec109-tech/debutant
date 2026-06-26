defmodule CheckInteger do
  require Integer
  def check_odd(x) do
    Integer.is_odd(x)
  end
end

IO.puts(CheckInteger.check_odd(3))
