defmodule QuoteWizard.Step.PaymentMethod do
  alias GenioTest.Quote.PaymentMethod
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias Ecto.Changeset

  def init(_quote), do: PaymentMethod.changeset(%PaymentMethod{})

  def update(quote, step_params) do
    step_params
    |> valid?(quote)
    |> persist!(quote)
  end

  defp valid?(step_params, quote) do
    case step_params["payment_method"] do
      nil -> {:error, :different_step, quote}
      _ -> 
        params = Utils.map_string_to_atom(step_params["payment_method"])
        changeset = PaymentMethod.changeset(%PaymentMethod{}, params)
        case changeset.valid? do
          true -> {:ok, params}
          false -> {:error, changeset}
        end
    end
  end

  defp persist!({:error,:different_step, _}, quote), do: {:ok, quote}
  defp persist!({:error, changeset}, quote), do: {:error, changeset, quote}
  defp persist!({:ok, params}, quote) do
    to_update = %{
      payment_method: params,
      step: Quote.next_step(quote.step)
    }
    quote 
    |> Changeset.change(to_update)
    |> Repo.update()
  end
end
