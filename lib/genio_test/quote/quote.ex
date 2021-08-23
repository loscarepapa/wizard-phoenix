import EctoEnum
defenum Step, quoting: 1, customer: 2, vehicle: 3, address: 4, payment_method: 5, summary: 6

defmodule GenioTest.Quote.Quote do 
  alias GenioTest.Quote.Customer
  alias GenioTest.Quote.Quoting
  alias GenioTest.Quote.Address
  alias GenioTest.Quote.Vehicle
  alias GenioTest.Quote.PaymentMethod
  use Ecto.Schema
  import Ecto.Changeset

  schema "quote" do
    field :token, :string
    field :step, Step
    field :ensurer_quote, :string 
    embeds_one :quoting, Quoting, on_replace: :update
    embeds_one :customer, Customer, on_replace: :update
    embeds_one :vehicle, Vehicle, on_replace: :update
    embeds_one :address, Address, on_replace: :update
    embeds_one :payment_method, PaymentMethod, on_replace: :update
  end

  @cast_params ~w(token step step)a
  @quoting_params ~w(vehicle_quote age name gender zip_code email phone)a
  @customer_params ~w(name email phone)a
  @vehicle_params ~w(make year_model version)a
  @address_params ~w(street external_number country)a
  @payment_method ~w(method periodicity)a

  def changeset(quote, attr \\ %{}) do
    quote
    |> set_token()
    |> cast(attr, @cast_params)
    |> cast_embed(:quoting, with: &quoting_changeset/2)
    |> cast_embed(:customer, with: &customer_changeset/2)
    |> cast_embed(:vehicle, with: &vehicle_changeset/2)
    |> cast_embed(:address, with: &address_changeset/2)
    |> cast_embed(:payment_method, with: &payment_method_changeset/2)
    |> validate_required([:token, :step])
    |> unique_constraint(:token)
  end

  defp quoting_changeset(schema, params) do
    schema
    |> cast(params, @quoting_params)
    |> validate_required(@quoting_params)
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

  defp address_changeset(schema, params) do
    schema
    |> cast(params, @address_params)
    |> validate_required(@address_params)
  end

  defp payment_method_changeset(schema, params) do
    schema
    |> cast(params, @payment_method)
    |> validate_required(@payment_method)
  end

  defp set_token(struct) do
    if Ecto.get_meta(struct, :state) == :built do
      struct |> Map.put(:token, UUID.uuid4(:hex))
    else
      struct
    end
  end
end
