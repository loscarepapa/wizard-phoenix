defmodule QuoteWizard do
  alias GenioTest.Repo
  alias GenioTest.Step.{
    Customer, 
    Vehicle,
    OptionsQuote,
    CustomerPolicy,
    Direction, 
    CustomerVehicle, 
    GoBack,
    Summary
  }

  def new(params), do: Customer.update(params)

  def current(token) do
    case Repo.get_by(GenioTest.Quote.Quote, token: token) do
      nil -> {:error, :quote_not_found}
      quote -> 
        step = get_step(quote)
        {:ok, quote, step.template(quote), step.changeset(quote)}
    end
  end

  def get_step(quote) do
    case quote.step do
      "1" -> Customer
      "2" -> Vehicle
      "3" -> OptionsQuote 
      "4" -> CustomerPolicy 
      "5" -> Direction 
      "6" -> CustomerVehicle 
      "7" -> Summary 
    end
  end

  def update(quote, params) do
    case params["go_back"] do
      "true" -> GoBack.update(quote)
      _ -> 
        case get_step(quote).update(quote, params) do
        {:ok, quote} -> {:ok, quote}
        {:error, :incomplet_form, changeset, template, params} -> 
          {:error, :incomplet_form, changeset, template, params}
        {:error, message} -> {:error, message}
      end
    end
  end

  def map_string_to_atom(params) do
    for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}
  end

  def update_step(quote) do
    "#{String.to_integer(quote.step) + 1}"
  end
end
