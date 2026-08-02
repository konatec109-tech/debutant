defmodule Transactions do

  transactions = [
    %{id: 1, type: :credit, amount: 1000, status: :failed},
    %{id: 2, type: :debit, amount: 500, status: :failed},
    %{id: 3, type: :credit, amount: 2000, status: :failed},
    %{id: 4, type: :debit, amount: 1500, status: :success},
    %{id: 5, type: :credit, amount: 3000, status: :success},
    %{id: 6, type: :debit, amount: 1000, status: :failed},
    %{id: 7, type: :credit, amount: 500, status: :success},
    %{id: 8, type: :debit, amount: 2000, status: :failed},
    %{id: 9, type: :credit, amount: 1500, status: :success},
    %{id: 10, type: :debit, amount: 2500, status: :success}
  ]

  success_transactions = Enum.filter(transactions, fn transaction -> transaction.status == :success end)
  IO.inspect(success_transactions)
  failed_transactions = Enum.filter(transactions, fn transaction -> transaction.status == :failed end)
  IO.inspect(failed_transactions)

 updated_success_transactions = Enum.map(success_transactions, fn transaction -> %{transaction | amount: transaction.amount + 5000}  end)

 IO.inspect(updated_success_transactions)

 total_success_amount = Enum.reduce(updated_success_transactions, 0, fn transaction, x -> transaction.amount + x end)
 IO.puts("Total amount of successful transactions: #{total_success_amount}")

 total_failed_amount = Enum.reduce(failed_transactions, 0, fn transaction, x -> transaction.amount + x end)
 IO.puts("Total amount of failed transactions: #{total_failed_amount}")
 
 filtered_transactions =
 transactions
 |> Enum.filter(fn t ->
  condition = (t.status == :success  and t.amount < 2000 )
  if condition do: IO.inspect(t)
end)
end

Transactions
