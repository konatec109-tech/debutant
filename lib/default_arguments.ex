defmodule Concat do
  @moduledoc """
  create module to concatenate three arguments with default value for the third argument
  """
  def concate(a, b, c \\ " ") do
  a <> c <> b
  end
  def dowork(x \\ "later") do
    x
  end
end

IO.puts(Concat.concate("hello", "world!"))
IO.puts(Concat.concate("hello", "world!", "_"))
IO.puts(Concat.dowork())
IO.puts(Concat.dowork("now"))
