defmodule Transactions do

  def successful_transactions(transactions) do
    transactions
    |> Enum.filter(fn t -> t.status == :success end)
  end



  def failed_transactions(transactions) do
    transactions
    |> Enum.filter(fn t -> t.status == :failed end)
  end

  @type transaction :: %{id: integer(), type: atom(), amount: integer(), status: atom()}
  def update_successful_transactions(transactions) do
    transactions
    |> Enum.filter(fn t -> t.status == :success end)
    |> Enum.map(fn t ->
      condition = if t.amount < 2000, do:   %{t | amount: t.amount + 5000}, else: t
       IO.inspect(condition)
    end)
  end



  def total_success_amount(success_transactions) do
   total_success_amount = success_transactions
    |> Enum.reduce(0, fn t, x -> t.amount + x end)
    IO.puts("Total amount of successful transactions: #{total_success_amount}")
    total_success_amount
  end


  def total_failed_amount(failed_transactions) do
    total_failed_amount = failed_transactions
    |> Enum.reduce(0, fn t, x -> t.amount + x end)
    IO.puts("Total amount of failed transactions: #{total_failed_amount}")
    total_failed_amount
  end


  def print_successful_transactions(transactions) do
  transactions
  |> Enum.filter(fn t -> t.status == :success end)
  |> Enum.each(fn t ->
    IO.puts("Transaction ID: #{t.id}, Type: #{t.type}, Amount: #{t.amount}, Status: #{t.status}") end)

  end

end

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

 success_t = Transactions.successful_transactions(transactions)
 IO.inspect(success_t)
 failed_t = Transactions.failed_transactions(transactions)
 IO.inspect(failed_t)
 updated_success_t = Transactions.update_successful_transactions(transactions)

 Transactions.print_successful_transactions(transactions)
 IO.inspect(updated_success_t)
 Transactions.total_success_amount(updated_success_t)
 IO.inspect(failed_t)
 Transactions.total_failed_amount(failed_t)
