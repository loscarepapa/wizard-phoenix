defmodule GenioTest.Quote.Quote do 
  alias GenioTest.Quote.Customer
  alias GenioTest.Quote.Vehicle
  use Ecto.Schema
  import Ecto.Changeset

  schema "quote" do
    field :token, :string
    embeds_one :customer, Customer, on_replace: :update
    embeds_one :vehicle, Vehicle, on_replace: :update
    field :ensurer_quote, :string
    field :policy, :map
    field :step, :string
  end

  @cast_params ~w(token policy step ensurer_quote)a
  @customer_params ~w(name email phone)a
  @vehicle_params ~w(make year_model version)a

  def changeset(quote, attr \\ %{}) do
    quote
    |> cast(attr, @cast_params)
    |> cast_embed(:customer, with: &customer_changeset/2)
    |> cast_embed(:vehicle, with: &vehicle_changeset/2)
    |> validate_required([:token, :step, :customer])
    |> unique_constraint(:token)
      end

  defp customer_changeset(schema, params) do
    schema
    |> cast(params, @customer_params)
    |> validate_required(@customer_params)
  end

  defp vehicle_changeset(schema, params) do
    schema
    |> cast(params, @vehicle_params)
    |> validate_required(@vehicle_params)
  end
end
