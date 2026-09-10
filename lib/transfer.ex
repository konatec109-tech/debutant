defmodule Send do
 alias WalletServer
 alias Account
 alias Transaction
 alias Learning.Repo

  def transfer_fund(sender_id, receiver_id, amount) do
    try do
      with {:ok, sender_account} <- WalletServer.get_struct_account(sender_id),
        {:ok, receiver_account} <- WalletServer.get_struct_account(receiver_id),
        {:success, updated_sender} <- Account.debit(sender_account, amount),
        {:success, updated_receiver} <- Account.credit(receiver_account, amount),

         multi <- build_transfer_multi(sender_account, receiver_account, updated_sender, updated_receiver, amount),
        {:ok, changes} <- Repo.transaction(multi) do
          WalletServer.sync_state(sender_id,  changes.debit_sender)
          WalletServer.sync_state(receiver_id,  changes.credit_receiver)
          {:success, :transferred}
      else
        {:error, reason} ->
          normalize_errors(reason)
        error ->
          normalize_errors(error)
      end

    rescue
      e in [Postgrex.Error, DBConnection.ConnectionError] ->
        normalize_errors(e)
    end
  end

  defp build_transfer_multi(sender_account, receiver_account, updated_sender, updated_receiver, amount) do
    params = %{
      amount: amount,
      status: "success",
      sender_id: sender_account.id,
      receiver_id: receiver_account.id
    }
    Ecto.Multi.new()
    |> Ecto.Multi.update(:debit_sender, Account.changeset(sender_account, %{balance_atomic: updated_sender.balance_atomic}))
    |> Ecto.Multi.update(:credit_receiver, Account.changeset(receiver_account, %{balance_atomic: updated_receiver.balance_atomic}))
    |> Ecto.Multi.insert(:insert_transaction, Transaction.changeset(params))
  end

  defp normalize_errors(reason) when is_atom(reason), do: {:error, reason}
  defp normalize_errors(%Postgrex.Error{} = e) do
    IO.inspect(e, label: "PANNE PHYSIQUE POSTGRESQL INTERCEPTEE")
    {:error, :database_hardware_failure}
  end

  defp normalize_errors(%DBConnection.ConnectionError{} = e) do
    IO.inspect(e, label: "COUPURE RESEAU BDD INTERCEPTEE")
    {:error, :database_network_timeout}
  end
  defp normalize_errors(unknown) do
    IO.inspect(unknown, label: "ERREUR INCONNU INTERCEPTEE")
    {:error, :unknown_system_failure}
  end
end
