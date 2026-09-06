defmodule Send do
  import Account, only: [debit: 2, credit: 2]
  alias Learning.Repo
  alias Account

  def transfer_fund(sender_id, receiver_id, amount) do
    Repo.transaction(fn ->
      sender = Repo.get!(Account, sender_id)
      receiver = Repo.get!(Account, receiver_id)

      with {:success, debited_sender} <- debit(sender, amount),
           {:success, credited_receiver} <- credit(receiver, amount) do


          sender_changeset = Account.changeset(sender, %{balance_atomic: debited_sender.balance_atomic})
          receiver_changeset = Account.changeset(receiver, %{balance_atomic: credited_receiver.balance_atomic})

          Repo.update!(sender_changeset)
          Repo.update!(receiver_changeset)

          %{type: :transfer, amount: amount, status: :success}
      else

        {:error, reason} ->
          Repo.rollback(reason)


      end


    end)

  end
end
