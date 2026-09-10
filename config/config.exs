import Config

config :learning, ecto_repos: [Learning.Repo]
config :learning, ash_domains: [Kpay.Payment]
config :ash, default_string_length_count: :codepoints
config :learning, ash_repos: [Learning.Repo]

config :learning, Learning.Repo,
  username: "postgres",
  password: "postgres_password",
  database: "learning_dev",
  hostname: "localhost",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true

import_config "#{Mix.env()}.exs"
