defmodule Workloads.Loads.Nat do
  use Agent

  def start_link() do
    Agent.start_link(fn -> 1 end, name: __MODULE__)
  end

  def next do
    x = Agent.get(__MODULE__, & &1)
    Agent.update(__MODULE__, &(&1 + 1))
    x
  end
end
