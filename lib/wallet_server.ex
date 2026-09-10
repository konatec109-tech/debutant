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
    case Registry.lookup(Learning.WalletRegistry, account_id) do
      [] ->
        {:error, :wallet_not_active}
      [{_pid, _value}] ->
        GenServer.call(via_tuple(account_id), {:debit, amount})

    end
  end

  def credit(account_id, amount) do
    case Registry.lookup(Learning.WalletRegistry, account_id) do
      [] ->
        {:error, :wallet_not_active}
      [{_pid, _value}] ->
        GenServer.call(via_tuple(account_id), {:credit, amount})
    end
  end

  def sync_state(account_id, fresh_account_from_db) do
    case Registry.lookup(Learning.WalletRegistry, account_id) do
      [] ->
        {:error, :wallet_not_active}
      [{_pid, _value}] ->
        GenServer.call(via_tuple(account_id), {:sync_state, fresh_account_from_db})
      end
  end

  def get_struct_account(account_id) do
    case Registry.lookup(Learning.WalletRegistry, account_id) do
      [] ->
        {:error, :wallet_not_active}
      [{_pid, _value}] ->
        GenServer.call(via_tuple(account_id), :get_struct_account)
    end
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
    {:reply, {:success, solde}, updated_account}
  end

  @impl true
  def handle_call({:debit, amount}, _from, account_from_db) do
    case Account.debit(account_from_db, amount) do
      {:success, updated_account} ->
        solde = updated_account.balance_atomic
        {:reply, {:success, solde}, updated_account}

      {:error, reason} ->
        {:reply, {:error, reason}, account_from_db}
    end
  end

  @impl true
  def handle_call(:get_struct_account, _from, account_from_db) do
    {:reply, {:ok, account_from_db}, account_from_db}
  end

  @impl true
  def handle_call({:sync_state, fresh_account_from_db}, _from, _old_state_in_ram) do
    {:reply, :ok, fresh_account_from_db}
  end
end
