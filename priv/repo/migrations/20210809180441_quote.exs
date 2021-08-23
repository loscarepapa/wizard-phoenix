defmodule GenioTest.Repo.Migrations.Quote do
  use Ecto.Migration

  def change do
    create table("quote") do
      add :token, :string
      add :step, :integer 
      add :quoting, :map, default: %{}
      add :ensurer_quote, :string
      add :customer, :map, default: %{}
      add :vehicle, :map, default: %{}
      add :address, :map, default: %{}
      add :payment_method, :map, default: %{}
      add :summary, :map, default: %{}
    end
  end
end
