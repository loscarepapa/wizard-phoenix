defmodule QuoteWizard.Step.PaymentMethod do
  alias GenioTest.Quote.PaymentMethod
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard

  def init(_quote), do: PaymentMethod.changeset(%PaymentMethod{})
  def changeset(quote), do:
    PaymentMethod.changeset(%PaymentMethod{}, quote.vehicle)

  def update(quote, params) do
    to_update = %{
      payment_method: Utils.map_string_to_atom(params["payment_method"]),
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
