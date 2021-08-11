defmodule GenioTestWeb.WizardController do
  alias QuoteWizard
  alias   alias GenioTest.Repo

  use GenioTestWeb, :controller

  def new(conn, _params) do
    render(conn, "customer.html")
  end

  def create(conn, params) do
    case QuoteWizard.new(params) do
      {:ok, quote} -> 
        redirect(conn, to: "/quote/#{quote.token}")
      {:error, _message} -> 
        redirect(conn, to: "/")
    end
  end

  def update(conn, params) do
    quote = Repo.get_by(GenioTest.Quote, token: params["token"])
    case QuoteWizard.update(quote, params) do
      {:ok, quote} -> 
        redirect(conn, to: "/quote/#{quote.token}")
      {:error, message} -> 
        redirect(conn, to: "/")
    end
  end

  def edit(conn, %{"token" => token}) do
    case QuoteWizard.current(token) do
      {:ok, quote, template} -> 
        render(conn, template, params: %{quote: quote})
      {:error, message} -> 
        redirect(conn, to: "/")
    end
  end
end
