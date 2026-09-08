defmodule Learning.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Learning.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import ExUnit.Case
    end
  end

  setup tags do
    _pid = Ecto.Adapters.SQL.Sandbox.checkout(Learning.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Learning.Repo, {:shared, self()})
    end
    :ok
  end
end
