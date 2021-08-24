defmodule QuoteWizard.Step.Quoting do
  alias GenioTest.Quote.Quoting
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias Utils

  def init(), do: Quoting.changeset(%Quoting{})

  def update(step_params) do
    step_params
    |> valid?()
    |> persist!()
  end

  defp valid?(step_params) do
    params = Utils.map_string_to_atom(step_params)
    changeset = Quoting.changeset(%Quoting{}, params)
    case changeset.valid? do
      true -> {:ok, params}
      false -> {:error, changeset}
    end
  end

  defp persist!({:error, changeset}), do: {:error, changeset}
  defp persist!({:ok, params}) do
    to_update = %{
      quoting: params,
      step: Quote.step_to_atom(2)
    }
    %Quote{} 
    |> Quote.changeset(to_update)
    |> Repo.insert()
  end
end
