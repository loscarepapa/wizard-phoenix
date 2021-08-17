defmodule GenioTest.Step.GoBack do
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset
  alias GenioTest.Step.{
    Customer, 
    Vehicle,
    OptionsQuote,
    CustomerPolicy,
    Direction, 
    GoBack,
    Summary
  }

  def update(quote) do
    {:ok, quote} = update_step( quote)
    step_module = QuoteWizard.get_step(quote)
    {:error, :incomplet_form, step_module.changeset(quote), step_module.template(quote), %{quote: quote}} 
  end

  def update_step(quote) do
    quote
    |> Changeset.change(%{step: "#{String.to_integer(quote.step) - 1}"})
    |> Repo.update()
  end
end
