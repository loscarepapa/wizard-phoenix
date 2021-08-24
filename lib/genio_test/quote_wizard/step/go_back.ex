defmodule QuoteWizard.Step.GoBack do
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset
  alias GenioTest.Quote.Quote

  @limit_go_back 4
  @max_go_back 6

  def update(quote, module) do
    {:ok, update_quote} = quote
    |> valid?
    |> persist!()

    step_module = module.get_step(update_quote)
    {:ok, step_module.init(update_quote), update_quote} 
  end

  defp valid?(quote) do
    current_step = Quote.step_to_int(quote.step)
    case current_step > @limit_go_back && current_step != @max_go_back  do
      true -> {:ok, quote, :persist}  
      false -> {:ok, quote}
    end
  end

  defp persist!({:ok, quote}), do: {:ok, quote}
  defp persist!({:ok, quote, :persist}) do
    quote
    |> Changeset.change(%{step: previus_step(quote.step)})
    |> Repo.update()
  end

   defp previus_step(current_step) when is_atom(current_step) == true do
    [{_, num}] = Enum.filter(Step.__enum_map__, fn {key, _val} -> key == current_step end)
    [{step, _}] = Enum.filter(Step.__enum_map__, fn {_key, val} -> val == num - 1 end)
    step
  end
end
