defmodule Utils do
  def map_string_to_atom(params), do:
    for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}

  def update_step(), do: 2
  def update_step(quote), do: quote.step + 1
  
  def current_step(step) when is_atom(step) == true do
    [{_step, num}] = Step.__enum_map__ |> Enum.filter(fn {key, _val} -> key == step end)
   num 
  end
  
  def current_step(step) when is_integer(step) == true do
    [{step, _num}] = Step.__enum_map__ |> Enum.filter(fn {_key, val} -> val == step end)
    step
  end

  def next_step(current_step) when is_atom(current_step) == true do
    [{_, num}] = Step.__enum_map__ |> Enum.filter(fn {key, _val} -> key == current_step end)
    [{step, _}] = Step.__enum_map__ |> Enum.filter(fn {_key, val} -> val == num + 1 end)
    step
  end
  def next_step(current_step) when is_integer(current_step) == true do
    [{step, _num}] = Step.__enum_map__ |> Enum.filter(fn {_key, val} -> val == current_step + 1 end)
    step
  end
end
