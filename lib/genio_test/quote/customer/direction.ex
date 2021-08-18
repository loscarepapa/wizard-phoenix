defmodule GenioTest.Quote.Customer.Direction do 
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :street, :string
    field :external_number, :string
    field :country, :string
  end

  @cast_params ~w(street external_number country)a

  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required(@cast_params)
  end
end
