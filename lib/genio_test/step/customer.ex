defmodule GenioTest.Step.Customer do
  alias GenioTest.Repo
  alias GenioTest.Quote.Quote
  @html "customer.html"

  def template(_quote), do: @html

  def update(params) do
    customer = QuoteWizard.map_string_to_atom(params)

    quote = %{}
            |> Map.put(:token, UUID.uuid4(:hex))
            |> Map.put(:customer, customer)
            |> Map.put(:step, "2")

    %Quote{}
    |> Quote.changeset(quote)
    |> Repo.insert
  end
end
