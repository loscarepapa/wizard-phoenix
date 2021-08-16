defmodule GenioTest.Quote.Customer do 
  use Ecto.Schema
  import Ecto.Changeset

 @primary_key false
 embedded_schema do
    field :name, :string
    field :phone, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :rfc, :string
    field :gender, :string
  end

  @cast_params ~w(name phone email first_name last_name rfc gender)a

  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required([:name, :phone, :email])
  end
end
