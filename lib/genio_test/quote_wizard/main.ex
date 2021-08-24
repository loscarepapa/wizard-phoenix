defmodule QuoteWizard do
  alias GenioTest.Repo
  alias QuoteWizard.Step.{
    Quoting,
    Customer, 
    Vehicle,
    Address,
    PaymentMethod,
    Summary,
    GoBack
  }

  def new(params), do: Quoting.update(params)

  def current(token) do
    case Repo.get_by(GenioTest.Quote.Quote, token: token) do
      nil -> {:error, :quote_not_found}
      quote -> 
        step = get_step(quote)
        {:ok, quote, step.init(quote)}
    end
  end

  def update(quote, params) do
    case params["go_back"] do
      "true" -> GoBack.update(quote, QuoteWizard)
      _ -> 
        case QuoteWizard.get_step(quote).update(quote, params) do
          {:ok, quote} -> {:ok, quote}
          {:error, changeset, params} -> 
            {:error, changeset, params}
          {:error, message} -> {:error, message}
        end
    end
  end

  def get_step(quote) do
    [{step, _val}] = Step.__enum_map__()
                     |> Enum.filter(fn {step, _number} -> quote.step == step end)

    case step do
      :quoting -> Quoting 
      :customer -> Customer 
      :vehicle -> Vehicle 
      :address -> Address 
      :payment_method -> PaymentMethod 
      :summary -> Summary 
    end
  end
end
