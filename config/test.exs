import Config

config :learning, ecto_repos: [Learning.Repo]

config :learning, Learning.Repo,
username: "postgres",
password: "postgres_password",
database: "learning_test",
hostname: "localhost",
pool: Ecto.Adapters.SQL.Sandbox
