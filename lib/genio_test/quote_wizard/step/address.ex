defmodule QuoteWizard.Step.Address do
  alias GenioTest.Quote.Address
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset

  def init(quote), do:
  Address.changeset(%Address{}, Map.from_struct(quote.address))

  def update(quote, params) do
    address_changeset = valid_address_params(params)
    case address_changeset.valid? do
      true -> 
        to_update = %{
          address: 
          quote.address 
          |> Map.from_struct 
          |> Map.merge(merge_address(params)),
          step: Utils.next_step(quote.step)
        }

        quote
        |> Changeset.change(to_update)
        |> Repo.update()

      false -> 
        {:error, address_changeset, quote} 
    end
  end

  def valid_address_params(params), do:
  Address.changeset(%Address{}, merge_address(params))

  def merge_address(params) do
    params
    |> Map.get("address")
    |> Utils.map_string_to_atom()
  end
end
