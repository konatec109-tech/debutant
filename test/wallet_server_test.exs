defmodule WalletServertest do
  use Learning.DataCase
  alias Learning.Repo
  alias Account
  alias WalletServer

  test "wake up a wallet dynamically and check out the balance" do
    params = %{name: "cedric", phone: "0706050403", balance_atomic: 50000}
    changeset = Account.changeset(%Account{}, params)
    account = Repo.insert!(changeset)
    DynamicSupervisor.start_child(Learning.WalletSupervisor, {WalletServer, account.id})
    solde_ram = WalletServer.get_balance(account.id)
    assert solde_ram == 50000
  end

  test "testing a ghost account" do
    result  = WalletServer.start_link(99999)
    assert {:error, :account_not_found} == result


  end
end
