defmodule Life do
  use GenServer
  alias Life.Board
  
  def init(name) do
    Process.send_after(self(), :tick, 1_000)
    {:ok, Board.new(name)}
  end
  
  def handle_info(:tick, board) do
    board |> Board.render |> IO.puts
    IO.puts("\n\n\n\n\n")
    Process.send_after(self(), :tick, 1_000)
    {:noreply, Board.next(board)}
  end
end
