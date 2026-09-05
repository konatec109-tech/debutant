defmodule WalletServer do
  use GenServer
  import Account, only: [credit: 2, debit: 2]

  def start_link(default_user \\ %{name: "ibrahim", age: 22, phone: "0704102697", balance_atomic: 50000}) do
    GenServer.start_link(__MODULE__, default_user, [])
   end

  def init(user) do
     {:ok, user}
  end

  def get_balance(pid) do
    GenServer.call(pid, :get_balance)
  end

  def handle_call(:get_balance, _from, user) do
    solde = user.balance_atomic
    {:reply, solde, user}
  end

  def handle_call({:credit, amount}, _from, user) do
    case credit(user, amount) do
      {:success, updated_user} ->
        {:reply, :ok, updated_user}
    end
  end

  def handle_call({:debit, amount}, _from, user) do
    case debit(user, amount) do
      {:success, updated_user} ->
        {:reply, :ok, updated_user}

      {:error, reason} ->
        {:reply, {:error, reason}, user}
    end
  end

  def credit_proccess(pid, amount) do
    GenServer.call(pid, {:credit, amount})
  end

  def debit_proccess(pid, amount) do
    GenServer.call(pid, {:debit, amount})
  end

end
