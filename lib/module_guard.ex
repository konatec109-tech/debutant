defmodule Verify do
  @moduledoc """
  create own module and define guard function to check if the number is zero or not
  """
  def zero?(0) do
    true
  end
  def zero?(x) when is_integer(x) do
    false
  end

  def verify_modulo(x) when rem(x, 2) == 0, do: true
  def verify_modulo(x) when rem(x, 2) != 0, do: false

end



IO.puts(Verify.zero?(0))
IO.puts(Verify.zero?(5))
IO.puts(Verify.verify_modulo(4))
IO.puts(Verify.verify_modulo(5))
