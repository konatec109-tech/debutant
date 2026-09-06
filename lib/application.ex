defmodule Learning.Application do
  use Application

  def start(_type, _args) do
    children = [
      Learning.Repo
    ]

    opts = [strategy: :one_for_one, name: Learning.Supervisor]

    Supervisor.start_link(children, opts)
  end


end
