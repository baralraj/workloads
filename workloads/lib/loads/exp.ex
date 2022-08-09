defmodule Workloads.Loads.Exp do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> 1 end, name: __MODULE__)
  end

  def next do
    x = Agent.get(__MODULE__, & &1)
    Agent.update(__MODULE__, &(&1 + 1))
    :math.pow(2, x) |> round()
  end

  def reset do
    Agent.update(__MODULE__, fn _ -> 1 end)
  end
end
