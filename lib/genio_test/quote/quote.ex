import EctoEnum
defenum Step, quoting: 1, customer: 2, vehicle: 3, address: 4, payment_method: 5, summary: 6

defmodule GenioTest.Quote.Quote do 
  alias GenioTest.Quote.PaymentMethod
  alias GenioTest.Quote.Quoting
  alias GenioTest.Quote.Customer
  alias GenioTest.Quote.Address
  alias GenioTest.Quote.Vehicle
  import Ecto.Changeset
  use Ecto.Schema

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

  @cast_params ~w(token step)a
  def changeset(quote, attr \\ %{}) do
    quote
    |> set_token()
    |> cast(attr, @cast_params)
    |> cast_embed(:quoting, with: &Quoting.changeset/2)
    |> cast_embed(:customer, with: &Customer.changeset/2)
    |> cast_embed(:vehicle, with: &Vehicle.changeset/2)
    |> cast_embed(:address, with: &Address.changeset/2)
    |> cast_embed(:payment_method, with: &PaymentMethod.changeset/2)
    |> validate_required(@cast_params)
    |> unique_constraint(:token)
  end

  defp set_token(struct) do
    if Ecto.get_meta(struct, :state) == :built do
      struct |> Map.put(:token, UUID.uuid4(:hex))
    else
      struct
    end
  end

  def step_to_atom(step) do
    [{step, _num}] = Step.__enum_map__ |> Enum.filter(fn {_key, val} -> val == step end)
    step
  end
  def step_to_int(step) do
    [{_step, num}] = Step.__enum_map__ |> Enum.filter(fn {key, _val} -> key == step end)
   num 
  end

  def next_step(current_step) when is_atom(current_step) == true do
    [{_, num}] = Step.__enum_map__ |> Enum.filter(fn {key, _val} -> key == current_step end)
    [{step, _}] = Step.__enum_map__ |> Enum.filter(fn {_key, val} -> val == num + 1 end)
    step
  end
  def next_step(current_step) when is_integer(current_step) == true do
    [{step, _num}] = Step.__enum_map__ |> Enum.filter(fn {_key, val} -> val == current_step + 1 end)
    step
  end
end
