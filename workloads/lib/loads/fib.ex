defmodule Workloads.Loads.Fib do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> [1, 1] end, name: __MODULE__)
  end

  def next do
    [x, _] = Agent.get(__MODULE__, & &1)
    Agent.update(__MODULE__, fn [x, y] -> [y, x + y] end)
    x
  end

  def reset do
    Agent.update(__MODULE__, fn _ -> [1, 1] end)
  end
end
