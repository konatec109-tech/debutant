defmodule Learning.Repo do
  use AshPostgres.Repo,
    otp_app: :learning,
    adapter: Ecto.Adapters.Postgres

    def min_pg_version do
      %Version{major: 16, minor: 0, patch: 0}
    end

    def installed_extensions do
      ["ash-functions"]
    end
end
