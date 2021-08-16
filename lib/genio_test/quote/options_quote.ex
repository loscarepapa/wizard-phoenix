defmodule GenioTest.Quote.OptionsQuote do 
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :quote_id, :string
  end

  @cast_params ~w(quote_id)a
  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required(@cast_params)
  end
end
