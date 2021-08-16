defmodule GenioTestWeb.WizardController do
  alias GenioTest.Quote.Customer
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias QuoteWizard

  use GenioTestWeb, :controller

  def new(conn, _params) do
    changeset = Customer.changeset(%Customer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"customer" => customer_params}) do
    case QuoteWizard.new(customer_params) do
      {:ok, quote} -> 
        redirect(conn, to: "/quote/#{quote.token}")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset.changes.customer)
    end
  end

  def update(conn, params) do
    quote = Repo.get_by(Quote, token: params["token"])
    case QuoteWizard.update(quote, params) do
      {:ok, quote} -> 
        redirect(conn, to: "/quote/#{quote.token}")
      {:error, :incomplet_form, %Ecto.Changeset{} = changeset, template, params} -> 
        render(conn, template, params: params, changeset: changeset)
        redirect(conn, to: "/")
      {:error, message} -> 
        redirect(conn, to: "/")
    end
  end

  def edit(conn, %{"token" => token}) do
    case QuoteWizard.current(token) do
      {:ok, quote, template, changeset} -> 
        render(conn, template, params: %{quote: quote}, changeset: changeset)
      {:error, message} -> 
        redirect(conn, to: "/")
    end
  end
end
