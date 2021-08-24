defmodule QuoteWizard.Step.Summary do
  def init(quote), do: quote
  def update(quote, _), do: {:ok, quote}
end
