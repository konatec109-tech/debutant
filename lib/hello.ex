defmodule Greet do
  @moduledoc """
  create module to greet the user with their name
  """
  def hello(name) do
    IO.puts("hello #{name}")
  end
end
