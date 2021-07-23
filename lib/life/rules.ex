defmodule Life.Rules do
  def maybe_spawn(n, _live) when n < 2, do: "."
  def maybe_spawn(n, _live) when n > 3, do: "."
  def maybe_spawn(3, _life), do: "O" 
  def maybe_spawn(2, life), do: life
end