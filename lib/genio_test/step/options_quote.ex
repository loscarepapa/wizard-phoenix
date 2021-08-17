defmodule GenioTest.Step.OptionsQuote do
  alias GenioTest.Quote.OptionsQuote
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset

  @current_template "options_quote.html"

  def template(_quote), do: @current_template 
  def changeset(_quote), do: OptionsQuote.changeset(%OptionsQuote{})

  def update(quote, params) do
    to_update = %{
      ensurer_quote: QuoteWizard.map_string_to_atom(params["options_quote"]) |> Map.get(:ensurer),
      step: QuoteWizard.update_step(quote)
    }

    quote
    |> Changeset.change(to_update)
    |> Repo.update()
  end
end
