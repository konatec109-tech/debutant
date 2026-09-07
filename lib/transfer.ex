defmodule Send do
 import WalletServer

  def transfer_fund(sender_id, receiver_id, amount) do
    with {:success, new_sender_balance} <- debit(sender_id, amount),
         {:success, new_receiver_balance} <- credit(receiver_id, amount) do
        %{type: :transfer, amount: amount, status: :success, sender_new_balance: new_sender_balance, receiver_new_balance: new_receiver_balance}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end
end
