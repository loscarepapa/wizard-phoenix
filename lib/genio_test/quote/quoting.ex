defmodule GenioTest.Quote.Quoting do 
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :vehicle_quote, :string
    field :age, :string
    field :name, :string
    field :gender, :string
    field :zip_code, :string
    field :email, :string
    field :phone, :string
  end

  @cast_params ~w(vehicle_quote age name gender zip_code email phone)a
  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required(@cast_params)
  end
end
