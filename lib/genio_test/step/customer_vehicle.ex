defmodule GenioTest.Step.CustomerVehicle do
  alias GenioTest.Quote.Customer.Vehicle
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset

  @current_template "customer_vehicle.html"

  def template(_quote), do: @current_template
  def changeset(quote), do: 
  Vehicle.changeset(%Vehicle{}, Map.from_struct(quote.customer_vehicle))

  def update(quote, params) do
    vehicle_changeset = valid_vehicle_params(params)
    case vehicle_changeset.valid? do
      true -> 
        to_update = %{
          customer_vehicle: 
          quote.customer_vehicle 
          |> Map.from_struct 
          |> Map.merge(merge_vehicle(params)),
          step: QuoteWizard.update_step(quote)
        }

        quote
        |> Changeset.change(to_update)
        |> Repo.update()

      false -> 
        {:error, :incomplet_form, vehicle_changeset, @current_template, %{quote: quote}} 
    end
  end

  def valid_vehicle_params(params), do:
  Vehicle.changeset(%Vehicle{}, merge_vehicle(params))

  def merge_vehicle(params) do
    params
    |> Map.get("vehicle")
    |> QuoteWizard.map_string_to_atom()
  end
end
