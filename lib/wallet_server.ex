defmodule WalletServer do
  use GenServer
  alias Learning.Repo
  alias Account


  def start_link(account_id) do
    GenServer.start_link(__MODULE__, account_id, name: via_tuple(account_id))
  end



  defp via_tuple(account_id) do
    {:via, Registry, {Learning.WalletRegistry, account_id}}
  end

  def get_balance(account_id) do
    GenServer.call(via_tuple(account_id), :get_balance)
  end



  def debit(account_id, amount) do
    GenServer.call(via_tuple(account_id), {:debit, amount})
  end

  def credit(account_id, amount) do
    GenServer.call(via_tuple(account_id), {:credit, amount})
  end

  @impl true
  def init(account_id) do
    account_from_db = Repo.get!(Account, account_id)
    {:ok, account_from_db}
  end

  @impl true
  def handle_call(:get_balance, _from, account) do
    solde = account.balance_atomic
    {:reply, solde, account}
  end

  @impl true
  def handle_call({:credit, amount}, _from, account) do
    {:success, updated_account} = Account.credit(account, amount)
    solde = updated_account.balance_atomic
    changeset = Account.changeset(updated_account, %{})
    Task.start(fn -> Repo.update!(changeset) end)
    {:reply, {:success, solde}, updated_account}
  end

  @impl true
  def handle_call({:debit, amount}, _from, account) do
    case Account.debit(account, amount) do
      {:success, updated_account} ->
        solde = updated_account.balance_atomic
        changeset = Account.changeset(updated_account, %{})
        Task.start(fn -> Repo.update!(changeset) end)
        {:reply, {:success, solde}, updated_account}

      {:error, reason} ->
        {:reply, {:error, reason}, account}
    end
  end
end
