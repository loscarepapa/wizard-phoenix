defmodule GenioTest.Step.Direction do
  alias GenioTest.Quote.Customer.Direction
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset

  @current_template "direction.html"

  def template(_quote), do: @current_template 
  def changeset(quote), do:
  Direction.changeset(%Direction{}, Map.from_struct(quote.direction))

  def update(quote, params) do
    direction_changeset = valid_direction_params(params)
    case direction_changeset.valid? do
      true -> 
        to_update = %{
          direction: 
          quote.direction 
          |> Map.from_struct 
          |> Map.merge(merge_direction(params)),
          step: QuoteWizard.update_step(quote)
        }
        quote
        |> Changeset.change(to_update)
        |> Repo.update()

      false -> 
        {:error, :incomplet_form, direction_changeset, @current_template, %{quote: quote}} 
    end
  end

  def valid_direction_params(params), do:
  Direction.changeset(%Direction{}, merge_direction(params))

  def merge_direction(params) do
    params
    |> Map.get("direction")
    |> QuoteWizard.map_string_to_atom()
  end
end
