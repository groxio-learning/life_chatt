defmodule Life.Board do
  alias Life.Rules
  
  def new(:repeater), do: repeater()
  def new(:block), do: block()
  def new(:dragon) do
    for row <- 1..20, col <- 1..20, into: %{} do
      {{row, col}, Enum.random(["O", "."])}
    end
  end
  
  def repeater do
    %{
        {1, 2} => "O", 
        {2, 2} => "O", 
        {3, 2} => "O"
    }
  end
  
  def block do
    %{
        {1, 2} => "O", 
        {1, 3} => "O", 
        {2, 2} => "O", 
        {2, 3} => "O", 
    }
  end
  
  def next(board) do
    for row <- 1..20, col <- 1..20, into: %{} do
      next_cell = 
        board 
        |> neighbors({row, col}) 
        |> Rules.maybe_spawn(fetch(board, {row, col}))
        
      {{row, col}, next_cell}
    end
  end
  
  defp fetch(board, cell) do
    Map.get(board, cell, ".")
  end
  
  defp neighbors(board, {r, c}) do
    for row <- (r-1)..(r+1), col <- (c-1)..(c+1), row != r or col != c do
      fetch(board, {row, col})
    end
    |> Enum.count(fn str -> str == "O" end)
  end
  
  def render(board) do
    for row <- 1..20 do
      for col <- 1..20 do
        fetch(board, {row, col})
      end
      |> Enum.join
    end
    |> Enum.join("\n")
  end
end


