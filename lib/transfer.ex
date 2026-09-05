defmodule Send do
    import Account
    def transfer(from, to, amount) do
        with {:success, updated_from} <- debit(from, amount),
             {:success, updated_to} <- credit(to, amount) do

          transactions = %{id: 1, type: :transfert, amount: amount, from: updated_from.balance_atomic, to: updated_to.balance_atomic, status: :success}
          {:success, transactions}
        else
          {:error, reason} -> {:error, "Transfer failed: #{reason}"}
        end
    end
end
