defmodule GenioTest.Repo.Migrations.Quote do
  use Ecto.Migration

  def change do
    create table("quote") do
      add :token, :string
      add :customer, :map, default: %{}
      add :vehicle, :map, default: %{}
      add :ensurer_quote, :string
      add :policy, :map, default: %{}
      add :step, :string, default: "1"
    end
  end
end
