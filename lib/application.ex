defmodule Learning.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique,  name: Learning.WalletRegistry},
      Learning.Repo,
      {DynamicSupervisor, strategy: :one_for_one, name: Learning.WalletSupervisor}
    ]
    opts = [strategy: :one_for_one, name: Learning.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
