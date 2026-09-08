defmodule TransferTest do
  use Learning.DataCase
  import Send
  alias Account
  alias Learning.Repo
  alias WalletServer


    test "transfer in ram and check new balance" do
      params_1 = %{name: "kassim", phone: "0909090909", balance_atomic: 50000}
      params_2 = %{name: "william", phone: "0101010101", balance_atomic: 10000}

      changeset_1 = Account.changeset(%Account{}, params_1)
      changeset_2 = Account.changeset(%Account{}, params_2)
      sender_account = Repo.insert!(changeset_1)
      receiver_account = Repo.insert!(changeset_2)

      DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, sender_account.id})
      DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, receiver_account.id})

      recu = transfer_fund(sender_account.id, receiver_account.id, 30000)
      solde_kassim_ram = WalletServer.get_balance(sender_account.id)
      solde_william_ram = WalletServer.get_balance(receiver_account.id)
      IO.inspect(solde_kassim_ram, label: "SOLDE KASSIM EN RAM")
      IO.inspect(solde_william_ram, label: "SOLDE WILLIAM EN RAM")
      assert recu.status == :success
      Process.sleep(50)

     kassim_disque = Repo.get!(Account, sender_account.id)
     william_disque = Repo.get!(Account, receiver_account.id)

     assert kassim_disque.balance_atomic == 20000
     assert william_disque.balance_atomic == 40000

    end

end
