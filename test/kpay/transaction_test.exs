defmodule Kpay.TransactionTest do
  use Learning.DataCase, async: true
  alias Kpay.Wallets.Account
  alias Kpay.Payment.Transaction
  test "atomic update in transaction between 2 accounts" do
    assert {:ok, ibrahim} = Ash.create(Account, %{name: "ibrahim", phone: "0704102697"})
    assert {:ok, kassim} = Ash.create(Account, %{name: "kassim", phone: "0706050403"})

    assert {:ok, ibrahim_credited} =
      ibrahim
      |> Ash.Changeset.for_update(:credit, [amount: 50000])
      |> Ash.update()

    assert {:ok, tx} =
      Transaction
      |> Ash.Changeset.for_create(:transfer,[
      from_account_id: ibrahim_credited.id,
      to_account_id: kassim.id,
      amount: 20000])
      |> Ash.create()

    {:ok, from_account_final} = Ash.get(Account, ibrahim.id)
    {:ok, to_account_final} = Ash.get(Account, kassim.id)

    assert from_account_final.balance == 30000
    assert to_account_final.balance == 20000
    assert tx.status == :success
  end

  test "rollback on failed operations" do
    assert {:ok, ibrahim} = Ash.create(Account, %{name: "ibrahim", phone: "0704102697"})
    assert {:ok, kassim} = Ash.create(Account, %{name: "kassim", phone: "0706050403"})

    assert {:error, error_changeset} =
      Transaction
      |> Ash.Changeset.for_create(:transfer, [
        from_account_id: ibrahim.id,
        to_account_id: kassim.id,
        amount: 10000])
      |> Ash.create()

    assert "insufficient fund for this operation" in Enum.map(error_changeset.errors, & &1.message)

    assert {:ok, from_account_final} = Ash.get(Account, ibrahim.id)
    assert {:ok, to_account_final} = Ash.get(Account, kassim.id)
    assert from_account_final.balance == 0
    assert to_account_final.balance == 0

  end
end
