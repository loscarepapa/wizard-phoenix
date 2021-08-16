defmodule GenioTest.Quote do
  alias GenioTest.Step.Customer
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard

  def create_quote(attrs \\ %{}), do: QuoteWizard.new(attrs)

  def get_quote!(id), do: Repo.get!(Quote, id)

  def change_quote(id), do: Repo.get!(Quote, id)
end
