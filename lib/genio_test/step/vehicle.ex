defmodule GenioTest.Step.Vehicle do
  alias GenioTest.Quote.Vehicle, as: VehicleSchema
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard

  @current_template "vehicle.html"

  def template(_quote), do: @current_template 
  def changeset(_quote), do: VehicleSchema.changeset(%VehicleSchema{})

  def update(quote, params) do
    to_update = %{
      vehicle: QuoteWizard.map_string_to_atom(params) |> Map.get(:vehicle),
      step: QuoteWizard.update_step(quote)
    }

    quote
    |> Quote.changeset(to_update)
    |> Repo.update()
  end
end
