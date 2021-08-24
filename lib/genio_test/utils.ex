defmodule Utils do
  def map_string_to_atom(params), do:
    for {key, val} <- params, into: %{}, do: {String.to_atom(key), val}

  def update_step(), do: 2
  def update_step(quote), do: quote.step + 1
end
