defmodule Account do
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

  @type user :: %{name: String.t(), age: integer(), phone: String.t(), balance_atomic: integer()}
  def credit({:success, user}, amount) when is_integer(amount) and amount > 0 do
    updated_balance = user.balance_atomic + amount
    updated_user = %{user | balance_atomic: updated_balance}
    user_info = {:success, updated_user}
    IO.inspect(user_info)
  end

  def debit({:success, user}, amount) when is_integer(amount) and amount > 0 do
    case user.balance_atomic do
      balance when balance >= amount ->
        updated_balance = user.balance_atomic - amount
        updated_user = %{user | balance_atomic: updated_balance}


        case updated_user.balance_atomic do
          balance when balance <= 1000 ->
            {:error, "Warning: Your balance is low. Your current balance is #{balance}."}
        end
        user_info = {:success, updated_user}
        IO.inspect(user_info)


      balance when balance < amount ->
        {:error, "Insufficient funds. Your current balance is #{balance}."}


    end
  end

end
