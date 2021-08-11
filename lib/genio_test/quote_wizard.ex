defmodule QuoteWizard do
  alias GenioTest.Repo
  alias GenioTest.Step.{
    Customer, 
    Vehicle,
    Policy,
    Summary 
  }

  def new(params), do: Customer.update(params)

  def current(token) do
    case Repo.get_by(GenioTest.Quote, token: token) do
      nil -> {:error, :quote_not_found}
      quote -> 
        {:ok, quote, get_step(quote).template()}
    end
  end

  defp get_step(quote) do
    case quote.step do
      "1" -> Customer
      "2" -> Vehicle
      "3" -> Policy 
      "4" -> Summary 
    end
  end

  def update(quote, params) do
    step_module = get_step(quote)
    case step_module.update(quote, params) do
      {:ok, quote} -> {:ok, quote}
      {:error, message} -> {:error, message}
    end
  end

  def map_string_to_atom(params) do
    for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}
  end

  def update_step(quote) do
    "#{String.to_integer(quote.step) + 1}"
  end
end
