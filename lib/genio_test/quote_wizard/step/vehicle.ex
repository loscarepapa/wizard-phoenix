defmodule QuoteWizard.Step.Vehicle do
  alias GenioTest.Quote.Vehicle, as: VehicleSchema
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard

  def init(_quote), do: VehicleSchema.changeset(%VehicleSchema{})
  def changeset(quote), do:
    VehicleSchema.changeset(%VehicleSchema{}, quote.vehicle)

  def update(quote, params) do
    to_update = %{
      vehicle: Utils.map_string_to_atom(params["vehicle"]),
      step: Utils.next_step(quote.step)
    }

    case quote
    |> Quote.changeset(to_update)
    |> Repo.update()
    do
      {:ok, quote} -> {:ok, quote}
      {:error, changeset} -> {:error, changeset, quote}
    end
  end
end
