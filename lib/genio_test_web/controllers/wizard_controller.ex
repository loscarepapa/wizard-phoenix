defmodule GenioTestWeb.WizardController do
  alias GenioTest.Quote.Quoting
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard

  use GenioTestWeb, :controller

  def new(conn, _params) do
    changeset = Quoting.changeset(%Quoting{})
    render(conn, "quoting.html", changeset: changeset)
  end

  def create(conn, %{"quoting" => quoting_params}) do
    case QuoteWizard.new(quoting_params) do
      {:ok, quote} -> 
        redirect(conn, to: "/quote/#{quote.token}")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, params) do
    quote = Repo.get_by(Quote, token: params["token"])
    case QuoteWizard.update(quote, params) do
      {:ok, quote} -> 
        redirect(conn, to: "/quote/#{quote.token}")
      {:error, changeset, params} -> 
        render(conn, get_step_template(params), params: params, changeset: changeset)
    end
  end

  def edit(conn, %{"token" => token}) do
    case QuoteWizard.current(token) do
      {:ok, quote, changeset} -> 
        render(conn, get_step_template(quote), params: quote, changeset: changeset)
      {:error, _message} -> 
        redirect(conn, to: "/")
    end
  end

  defp get_step_template(quote) do
    "#{to_string(quote.step)}.html"
  end
end
