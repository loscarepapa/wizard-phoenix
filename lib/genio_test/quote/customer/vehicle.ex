defmodule GenioTest.Quote.Customer.Vehicle do 
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :motor, :string
    field :serie, :string
  end

  @cast_params ~w(motor serie)a

  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required(@cast_params)
  end
end
