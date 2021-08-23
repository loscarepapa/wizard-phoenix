defmodule QuoteWizard.Step.Quoting do
  alias GenioTest.Quote.Quoting
  alias GenioTest.Quote.Quote
  alias GenioTest.Repo
  alias Utils

  def init(), do: Quoting.changeset(%Quoting{})

  def update(step_params) do
    step_params
    |> valid?()
    |> save()
  end

  defp valid?(step_params) do
    params = Utils.map_string_to_atom(step_params)
    changeset = Quoting.changeset(%Quoting{}, params)
    case changeset.valid? do
      true -> {:ok, params}
      false -> {:error, changeset}
    end
  end

  defp save({:error, changeset}), do: {:error, changeset}
  defp save({:ok, params}) do
        to_update = %{
          quoting: params,
          step: Utils.update_step()
        }
   %Quote{} 
    |> Quote.changeset(to_update)
    |> Repo.insert()
  end
end
