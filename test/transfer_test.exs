defmodule TransferTest do
  use Learning.DataCase
  import Send
  alias Account
  alias WalletServer


  test "transfer in ram and check new balance" do
    params_1 = %{name: "kassim", phone: "0909090909", balance_atomic: 50000}
    params_2 = %{name: "william", phone: "0101010101", balance_atomic: 10000}

    changeset_1 = Account.changeset(%Account{}, params_1)
    changeset_2 = Account.changeset(%Account{}, params_2)
    kassim = Repo.insert!(changeset_1)
    william = Repo.insert!(changeset_2)

    DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, kassim.id})
    DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, william.id})

    assert {:success, :transferred} == transfer_fund(kassim.id, william.id, 30000)

    solde_kassim = WalletServer.get_balance(kassim.id)
    solde_william = WalletServer.get_balance(william.id)
    assert solde_kassim == 20000
    assert solde_william == 40000


    kassim_disque = Repo.get!(Account, kassim.id)
    william_disque = Repo.get!(Account, william.id)

    assert kassim_disque.balance_atomic == 20000
    assert william_disque.balance_atomic == 40000
  end

  test "insufficient balance test" do
    params_1 = %{name: "kassim", phone: "0909090909", balance_atomic: 50000}
    params_2 = %{name: "william", phone: "0101010101", balance_atomic: 10000}

    changeset_1 = Account.changeset(%Account{}, params_1)
    changeset_2 = Account.changeset(%Account{}, params_2)
    kassim = Repo.insert!(changeset_1)
    william = Repo.insert!(changeset_2)

    DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, kassim.id})
    DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, william.id})

    assert {:error, :insufficient_funds} == transfer_fund(kassim.id, william.id, 60000)

    solde_kassim = WalletServer.get_balance(kassim.id)
    solde_william = WalletServer.get_balance(william.id)
    assert solde_kassim == 50000
    assert solde_william == 10000


    kassim_disque = Repo.get!(Account, kassim.id)
    william_disque = Repo.get!(Account, william.id)

    assert kassim_disque.balance_atomic == 50000
    assert william_disque.balance_atomic == 10000

  end

  test " test wallet not active error when id is fake" do
    params = %{name: "william", phone: "0101010101", balance_atomic: 10000}
    changeset = Account.changeset(params)
    william = Repo.insert!(changeset)
    DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, william.id})
    result = transfer_fund(99999, william.id, 5000)
    assert result == {:error, :wallet_not_active}



  end





end
