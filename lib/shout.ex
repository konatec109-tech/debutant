defmodule Shout do
  @moduledoc """
  create a module to covert string to uppercase
  """
  def uppercase(x \\ "hello world") do
    String.upcase(x)
    <> "\n" <> add_greeting(x)
  end
  @spec add_greeting(String.t()) :: String.t()
  defp add_greeting(x) do
    "hello #{x}"
  end
end


