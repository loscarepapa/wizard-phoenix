defmodule GenioTest.Step.Policy do
  alias GenioTest.Repo
  alias QuoteWizard
  alias GenioTest.Quote
  alias Ecto.Changeset

  @current_template "policy.html"

  def template(), do: @current_template 

  def update(quote, params) do
    policy = QuoteWizard.map_string_to_atom(params)
             |> Map.delete(:_csrf_token)
             |> Map.delete(:token)

    update_step = QuoteWizard.update_step(quote)

    updated_quote = quote
                    |> Changeset.change(%{policy: policy, step: update_step})
                    |> Repo.update!()
                    |> get_updated_quote()

    {:ok, updated_quote}
  end

  def get_updated_quote(quote) do
    Repo.get_by!(Quote, token: quote.token)
  end
end
