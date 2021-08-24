defmodule GenioTestWeb.WizardController do
  alias GenioTest.Quote.Quoting
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard

  @finish_step :summary

  use GenioTestWeb, :controller

  def new(conn, _params) do
    changeset = Quoting.changeset(%Quoting{})
    render(conn, "quoting.html", changeset: changeset)
  end

  def create(conn, %{"quoting" => quoting_params}) do
    case QuoteWizard.new(quoting_params) do
      {:ok, quote} -> 
        redirect(conn, to: "/quotes/#{quote.token}/edit")
      {:error, changeset} ->
        render(conn, "quoting.html", changeset: changeset)
    end
  end

  def update(conn, params) do
    quote = Repo.get_by(Quote, token: params["id"])
    case QuoteWizard.update(quote, params) do
      {:ok, quote} -> 
        case quote.step == @finish_step do
          :true -> redirect(conn, to: "/quotes/#{quote.token}")
          :false -> redirect(conn, to: "/quotes/#{quote.token}/edit")
        end
      {:ok, changeset, params} -> 
        render(conn, get_step_template(params), params: params, changeset: changeset)
      {:error, changeset, params} -> 
        render(conn, get_step_template(params), params: params, changeset: changeset)
    end
  end

  def edit(conn, params) do
    case QuoteWizard.current(params["id"]) do
      {:ok, quote, changeset} -> 
        render(conn, get_step_template(quote), params: quote, changeset: changeset)
      {:error, _message} -> 
        redirect(conn, to: "/")
    end
  end

  def show(conn, %{"id" => id}) do
    with quote <- Repo.get_by(Quote, token: id),
         true <- quote != nil,
         true <- quote.step == @finish_step do
        render(conn, "summary.html", params: quote)
    else
      _ -> redirect(conn, to: "/quotes/#{id}/edit")
    end
  end

  defp get_step_template(quote) do
    "#{to_string(quote.step)}.html"
  end
end
