defmodule Learning.Repo do
  use Ecto.Repo,
    otp_app: :learning,
    adapter: Ecto.Adapters.Postgres
end
