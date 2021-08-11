defmodule GenioTest.Quote do 
  use Ecto.Schema
  import Ecto.Changeset

  schema "quote" do
    field :token, :string
    field :customer, :map
    field :vehicle, :map
    field :policy, :map
    field :step, :string
  end

  @cast_params ~w(token customer vehicle policy step)a

  def changeset(quote, attr) do
    quote
    |> cast(attr, @cast_params)
    |> validate_required([:token, :step, :customer])
    |> unique_constraint(:token)
  end
end
