defmodule Matching do
  @moduledoc """
  create a module to see pattern matching in action
  """
  def score(oscar, will, arthur) do
    case {oscar, will, arthur} do
      {o, w, a} when o <= 0 or w <= 0 or a <= 0 ->
        {:error, "score cannot be negative"}

      {o, w, a} when o > w and o > a ->
        {:ok, {:oscar, o}}

      {o, w, a} when w > o and w > a ->
         {:ok, {:will, w}}

      {o, w, a} when a > o and a > w ->
        {:ok, {:arthur, a}}

      _ ->
        {:error, "there is tie between the players"}
    end
  end

  defp display_message(result) do
    case result do
      {:ok, {player, score}} ->
        IO.puts("The winner is #{player} with  score #{score}")

      {:error, message} ->
        IO.puts("Error: #{message}")
    end
  end

  def run(will, oscar, arthur) do
    result = score(oscar, will, arthur)
    display_message(result)
  end

  
end
