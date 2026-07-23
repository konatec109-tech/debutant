defmodule Account do
  import Matching
  def register_user do
    name = IO.gets("Enter your name: ") |> String.trim()
    age = verify_age()
    phone = verify_phone()
    IO.puts("User registered successfully!")
    user_info = {:success, %{name: name, age: age, phone: phone, balance_atomic: 50000}}
    IO.inspect(user_info)

  end
  defp verify_phone do
    phone = IO.gets("Enter your phone Number: ") |> String.trim()
    if phone =~ ~r/^\d{10}$/ do
        phone

    else
        IO.puts("Invalid phone number. please enter a valid 10-digit phone number")
        verify_phone()
    end
  end
  defp verify_age do
    age = IO.gets("Enter your age: ") |> String.trim()
    case Integer.parse(age) do
      {age, ""} when age >= 18 ->
        age

      {age, ""} when age < 18 ->
        IO.puts("Age must be at least 18.")
        verify_age()

      {_age, _rest} ->
        IO.puts("Invalid age Input. Please enter a valid integer.")
        verify_age()

      :error ->
        IO.puts("Invalid age Input. Please enter a valid integer.")
        verify_age()
    end
  end

end
