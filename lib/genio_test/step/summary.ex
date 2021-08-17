defmodule GenioTest.Step.Summary do
  alias GenioTest.Quote.Customer.Direction
  @current_template "summary.html"

  def template(_quote), do: @current_template 
  def changeset(_quote), do: %{} 
end
