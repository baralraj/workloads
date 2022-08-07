defmodule Workloads.Loads.Fib2 do
  use Agent

  def start_link() do
    Agent.start_link(fn -> [2, 3] end, name: __MODULE__)
  end

  def next do
    [x, _] = Agent.get(__MODULE__, & &1)
    Agent.update(__MODULE__, fn [x, y] -> [y, x * y] end)
    x
  end

  def reset do
    Agent.update(__MODULE__, fn _ -> [1, 1] end)
  end
end
