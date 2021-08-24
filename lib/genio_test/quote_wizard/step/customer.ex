defmodule QuoteWizard.Step.Customer do
  alias GenioTest.Quote.Customer
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias Ecto.Changeset

  def init(_quote), do: Customer.changeset(%Customer{})

  def update(quote, step_params) do
    step_params
    |> valid?()
    |> persist!(quote)
  end

  defp valid?(step_params) do
    params = Utils.map_string_to_atom(step_params["customer"])
    changeset = Customer.changeset(%Customer{}, params)
    case changeset.valid? do
      true -> {:ok, params}
      false -> {:error, changeset}
    end
  end

  defp persist!({:error, changeset}, quote), do: {:error, changeset, quote}
  defp persist!({:ok, params}, quote) do
    to_update = %{
      customer: params,
      step: Quote.next_step(quote.step)
    }
    quote 
    |> Changeset.change(to_update)
    |> Repo.update()
  end
end
