defmodule GenioTest.Repo do
  use Ecto.Repo,
    otp_app: :genio_test,
    adapter: Ecto.Adapters.Postgres
end
