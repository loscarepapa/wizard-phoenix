defmodule QuoteWizard.Step.Address do
  alias GenioTest.Quote.Address
  alias GenioTest.Repo
  alias Ecto.Changeset
  alias GenioTest.Quote.Quote

  def init(quote), do:
  Address.changeset(%Address{}, Map.from_struct(quote.address))

  def update(quote, step_params) do
    step_params
    |> valid?()
    |> persist!(quote)
  end

  defp valid?(step_params) do
    params = Utils.map_string_to_atom(step_params["address"])
    changeset = Address.changeset(%Address{}, params)
    case changeset.valid? do
      true -> {:ok, params}
      false -> {:error, changeset}
    end
  end

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
