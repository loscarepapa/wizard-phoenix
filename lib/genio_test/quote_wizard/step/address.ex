defmodule QuoteWizard.Step.Address do
  alias GenioTest.Quote.Address
  alias GenioTest.Repo
  alias Ecto.Changeset
  alias GenioTest.Quote.Quote

  def init(quote), do:
  Address.changeset(%Address{}, Map.from_struct(quote.address))

  def update(quote, step_params) do
    step_params
    |> valid?(quote)
    |> persist!(quote)
  end

  defp valid?(step_params, quote) do
    case step_params["address"] do
      nil -> {:error, :different_step, quote} 
      _ -> 
        params = Utils.map_string_to_atom(step_params["address"])
        changeset = Address.changeset(%Address{}, params)
        case changeset.valid? do
          true -> {:ok, params}
          false -> {:error, changeset}
        end
    end
  end

  defp persist!({:error,:different_step, _}, quote), do: {:ok, quote}
  defp persist!({:error, params}, quote), do: {:error, params, quote} 
  defp persist!({:ok, params}, quote) do
    to_update = %{
      address: params,
      step: Quote.next_step(quote.step)
    }

    quote
    |> Changeset.change(to_update)
    |> Repo.update()
  end
end
