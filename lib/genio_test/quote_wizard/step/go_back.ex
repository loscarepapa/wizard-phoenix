defmodule QuoteWizard.Step.GoBack do
  alias GenioTest.Repo
  alias QuoteWizard
  alias Ecto.Changeset

  @limit_go_back 4

  def update(quote) do
    {:ok, quote} = update_step( quote)
    step_module = QuoteWizard.get_step(quote)
    {:error, step_module.init(quote), quote} 
  end

  def update_step(quote) do
    case Utils.current_step(quote.step) > @limit_go_back do
      true ->     
        quote
        |> Changeset.change(%{step: previus_step(quote.step)})
        |> Repo.update()
      false -> {:ok, quote}
    end
  end

   def previus_step(current_step) when is_atom(current_step) == true do
    [{_, num}] = Step.__enum_map__ |> Enum.filter(fn {key, _val} -> key == current_step end)
    [{step, _}] = Step.__enum_map__ |> Enum.filter(fn {_key, val} -> val == num - 1 end)
    step
  end
end
