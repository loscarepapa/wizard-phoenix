defmodule QuoteWizard.Step.Customer do
  alias GenioTest.Quote.Customer
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias Ecto.Changeset

  def init(_quote), do: Customer.changeset(%Customer{})
  
  def update(quote, step_params) do
    step_params
    |> valid?(quote)
    |> persist!(quote)
  end

  defp valid?(step_params, quote) do
    params = Utils.map_string_to_atom(step_params["customer"])
    changeset = Customer.changeset(%Customer{}, params)

    with :customer <- quote.step,
         true <- changeset.valid?do
         {:ok, params}
    else
      _ -> {:error, changeset}
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
