defmodule GenioTest.Step.Customer do
  alias GenioTest.Repo
  alias GenioTest.Quote
  @html "customer.html"

    def template(), do: @html

  def update(params) do
    customer = QuoteWizard.map_string_to_atom(params)
               |> Map.delete(:_csrf_token)

    quote = %{}
            |> Map.put(:token, UUID.uuid4(:hex))
            |> Map.put(:customer, customer)
            |> Map.put(:step, "2")

    quote_struct = Quote.changeset(%Quote{}, quote)

    case Repo.insert(quote_struct) do
      {:ok, response} -> {:ok, response}
      _ -> {:error, :error_to_save}
    end
  end
end
