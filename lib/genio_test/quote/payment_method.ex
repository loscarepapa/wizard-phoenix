defmodule GenioTest.Quote.PaymentMethod do 
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :method, :string
    field :periodicity, :string
  end

  @cast_params ~w(method periodicity)a

  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required([:method, :periodicity])
  end
end
