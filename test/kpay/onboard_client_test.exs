defmodule Kpay.OnboardClientTest do
  use Learning.DataCase, async: true
  alias Kpay.Wallets.{Account, Wallet}
  alias Kpay.Banking.{Bank, BankTenant}
  import Ash.Query

  test "create wallet then account right after" do
    assert {:ok, bank} =
      Bank
      |> Ash.Changeset.for_create(:create, [name: "NSIA Bank", bic_code: "NSIACIAB"])
      |> Ash.create()
    assert {:ok, tenant} =
      BankTenant
      |> Ash.Changeset.for_create(:create, [slug: "univ-cocody", bank_id: bank.id])
      |> Ash.create()

    assert {:ok, wallet} =
      Wallet
      |> Ash.Changeset.for_create(:create_client_onboarding,
      [bank_tenant_id: tenant.id,
      name: "ibrahim junior konate",
      phone: "0704102697"])
      |> Ash.create

      assert {:ok, account} =
        Account
        |> filter(wallet_id == ^wallet.id)
        |> Ash.read_one()

      assert account.name == "ibrahim junior konate"
      assert account.wallet_id == wallet.id
      assert account.phone == "0704102697"
      assert account.balance == 0

  end
end
