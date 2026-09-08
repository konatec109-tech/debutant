defmodule WalletServer do
  use GenServer
  alias Learning.Repo
  alias Account


  def start_link(account_id) do
    case Repo.get(Account, account_id) do
      nil ->
        {:error, :account_not_found}

      account_from_db ->
        GenServer.start_link(__MODULE__, account_from_db, name: via_tuple(account_id))
    end
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
  def init(account_from_db) do
    {:ok, account_from_db}

  end

  @impl true
  def handle_call(:get_balance, _from, account_from_db) do
    solde = account_from_db.balance_atomic
    {:reply, solde, account_from_db}
  end

  @impl true
  def handle_call({:credit, amount}, _from, account_from_db) do
    {:success, updated_account} = Account.credit(account_from_db, amount)
    solde = updated_account.balance_atomic
    changeset = Account.changeset(account_from_db, %{balance_atomic: solde})
    saved_account = Repo.update!(changeset)
    {:reply, {:success, solde}, saved_account}
  end

  @impl true
  def handle_call({:debit, amount}, _from, account_from_db) do
    case Account.debit(account_from_db, amount) do
      {:success, updated_account} ->
        solde = updated_account.balance_atomic
        changeset = Account.changeset(account_from_db, %{balance_atomic: solde})
        saved_account = Repo.update!(changeset)
        {:reply, {:success, solde}, saved_account}

      {:error, reason} ->
        {:reply, {:error, reason}, account_from_db}
    end
  end
end
