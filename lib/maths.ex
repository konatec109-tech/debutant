# learning elixir module and functions definition
defmodule Maths do
  @moduledoc """
  create own maths module and define basics maths functions
  """
  @doc "sum of two numbers"
  def sum(a, b) do
    IO.puts("the sum of #{a} and #{b} is #{a + b}")
  end

  def sum_three(a, b, c) do
    sum_private(a, b, c)
  end

  defp sum_private(a, b, c) do
    IO.puts("the sum of #{a}, #{b} and #{c}, is #{a + b + c}")
  end

  @doc "multiply of two numbers"
  def times(a, b) do
    IO.puts("the multiplication of #{a} and #{b} is #{a * b}")
  end

  @doc "subtract of two numbers"
  def substract(a, b) do
    IO.puts("the subtraction of #{a} and #{b} is #{a - b}")
  end

  @doc "divide of two numbers"
  def divide(a, b) do
    IO.puts("the division of #{a} and #{b} is #{a / b}")
  end

  @doc "modulo of two numbers"
  def modulo(a, b) do
    IO.puts("the modulo of #{a} and #{b} is #{rem(a, b)}")
  end

  @doc "power of one number to another"
  def p(a, b) do
    IO.puts("the power of #{a} to #{b} is #{:math.pow(a, b)}")
  end

  def test_alias_local do
    alias Shout
    IO.puts("Voici ce que donne le alis local: ")
    IO.puts Shout.uppercase("françois")

  end
end

Maths.sum(5, 10)
Maths.sum_three(3, 5, 7)
Maths.times(5, 10)
Maths.substract(5, 10)
Maths.divide(7, 2)
Maths.modulo(7, 2)
Maths.p(2, 3)
Maths.test_alias_local()
