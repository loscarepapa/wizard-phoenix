defmodule GenioTest.Quote.Customer.Customer do 
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :first_name, :string
    field :last_name, :string
    field :rfc, :string
    field :gender, :string
  end

  @cast_params ~w(first_name last_name rfc gender)a

  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required(@cast_params)
  end
end
