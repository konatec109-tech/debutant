defmodule WalletServer do
  use GenServer

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

end
