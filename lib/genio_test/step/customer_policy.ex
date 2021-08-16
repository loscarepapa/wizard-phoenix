defmodule GenioTest.Step.CustomerPolicy do
  alias GenioTest.Customer.Customer
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset

  @current_template "customer_policy.html"

  def template(_quote), do: @current_template
  def changeset(_quote), do: Customer.changeset(%Customer{})

  def update(quote, params) do
    customer_changeset = valid_customer_params(params)
    case customer_changeset.valid? do
      true -> 
        to_update = %{
          customer: 
          quote.customer 
          |> Map.from_struct 
          |> Map.merge(merge_customer(params)),
          step: QuoteWizard.update_step(quote)
        }
        quote
        |> Changeset.change(to_update)
        |> Repo.update()

      false -> 
        {:error, :incomplet_form, customer_changeset, @current_template, %{quote: quote}} 
    end
  end

  def valid_customer_params(params) do
  Customer.changeset(%Customer{}, merge_customer(params))
  end

  def merge_customer(params) do
    params
    |> Map.get("customer")
    |> QuoteWizard.map_string_to_atom()
  end
end
